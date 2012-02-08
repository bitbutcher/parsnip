module Parsnip

  class Railtie < Rails::Railtie

    initializer 'parsnip.add_middleware' do | app |
      app.config.middleware.insert_before(ActionDispatch::ParamsParser, Parsnip::Middleware)
    end

  end

end
