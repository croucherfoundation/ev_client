require 'settings'
require 'faraday_middleware'
require 'her'
require 'her/middleware/json_api_parser'

api_url = ENV['EV_API_URL'] || "#{Settings.ev.protocol}://#{Settings.ev.api_host}:#{Settings.ev.api_port}"

EVENTS_API = Her::API.new
EVENTS_API.setup url: api_url do |c|
  # Request
  c.use FaradayMiddleware::EncodeJson
  # Response
  c.use Her::Middleware::JsonApiParser
  c.use Faraday::Adapter::NetHttp
end
