# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

run Rails.application

use Rack::Cors do
  allow do
    origins 'localhost:3000', 'localhost:3001', '192.168.0.13:3000',
            %r{\Ahttp://192\.168\.0\.\d{1,3}(:\d+)?\z}
    # regular expressions can be used here

    resource '/file/list_all/', headers: 'x-domain-token'
    resource '/file/at/*',
             methods: %i[get post delete put patch options head],
             headers: 'x-domain-token',
             expose: ['Some-Custom-Response-Header'],
             max_age: 600
    # headers to expose
  end

  allow do
    origins '*'
    resource '/public/*', headers: :any, methods: :get

    # Only allow a request for a specific host
  end
end