require 'parsnip/version'
require 'parsnip/railtie' if defined? Rails
require 'sinatra/base'
require 'json'
require 'nokogiri'

module Parsnip

  class Middleware < Sinatra::Base

    disable :show_exceptions

    enable :raise_errors

    post '*' do
      parse_nip(request) || pass
    end

    put '*' do
      parse_nip(request) || pass
    end

    patch '*' do
      parse_nip(request) || pass
    end

    private

    def parse_nip(request)
      case request.content_type.downcase
      when /json/
        with_rewind(request) { |body| json_nip(body) }
      when /xml/
        with_rewind(request) { |body| xml_nip(body) }
      end
    end

    def json_nip(body)
      JSON.parse(body) and nil
    rescue JSON::ParserError => e
      nip({ error: e.to_s }.to_json, 'application/json; charset=utf-8')
    end

    def xml_nip(body)
      (Nokogiri::XML(body) { | config | config.strict }) and nil
    rescue Nokogiri::XML::SyntaxError => e
      error = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do | xml |
        xml.error e.to_s
      end
      nip(error.to_xml, 'application/xml; charset=utf-8')
    end

    def nip(body, type)
      [ 400, { 'Content-Type' => type }, [ body ] ]
    end

    def with_rewind(request, &nipper)
      begin
        nipper.call(request.body.read)
      ensure
        request.body.rewind
      end
    end
  
  end  

end
