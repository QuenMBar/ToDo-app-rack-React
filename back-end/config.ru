require 'rack/cors'
require_relative './config/environment.rb'

use Rack::Cors do
    allow do
        origins '*'
        resource '/*', headers: :any, methods: %i[get post patch put delete]
    end
end

run Application.new
