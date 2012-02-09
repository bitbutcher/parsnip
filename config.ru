# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../lib/parsnip',  __FILE__)
run Parsnip::Middleware
