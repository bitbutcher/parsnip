# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'parsnip/version'

Gem::Specification.new do |s|
  s.name        = "parsnip"
  s.version     = Parsnip::VERSION
  s.authors     = ['Sean M. Duncan']
  s.email       = ['bitbutcher@gmail.com']
  s.summary     = %q{Rack Middleware that nips parsing errors in the bud before they manifest as internal server errors}

  s.rubyforge_project = "parsnip"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = [ 'lib' ]

  
  s.add_development_dependency 'rspec'
  s.add_runtime_dependency 'sinatra'
  s.add_runtime_dependency 'json'
  s.add_runtime_dependency 'nokogiri'
end
