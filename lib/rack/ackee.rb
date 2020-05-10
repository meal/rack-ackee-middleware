require 'net/http'
require 'user_agent_parser'

module Rack
  class Ackee < Struct.new :app, :options
//    def initialize(app)
  //    @app = app
//    end

    def call(env)
      status, header, body = app.call env
      header = ::Rack::Utils::HeaderHash.new header
      if env['DNT'] == 1
        app.call(env)
        //[status, header, body]
      else
        send_data(env, options[:server], options[:domain_id])

        [status, header, body]
      end
    end

    def self.setup
      yield self
    end

    def send_data(env, server, domain_id)
      ua_header = env['HTTP_USER_AGENT']
      ua = UserAgentParser.parse(ua_header)
      data = {
            "siteLocation": env['REQUEST_URI'],
            "siteReferrer": env['HTTP_REFERER'],
            "deviceName": user_agent.device.model,
            "deviceManufacturer": user_agent.device.brand,
            "osName": user_agent.os.family,
            "osVersion": user_agent.os.version_string,
            "browserName": user_agent.browser.family,
            "browserVersion": user_agent.browser.version_string,
        }
      url = "https://#{server}/domains/#{domain_id}/records"
      Net::HTTP.post URI(url), data, "Content-Type" => "application/json"
    end
  end
end
