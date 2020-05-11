require 'net/http'
require 'user_agent_parser'

module Rack
  class Ackee

    def initialize(app, options={})
      @app = app
      @server = options[:server]
      @domain_id = options[:domain]
    end

    def call(env)
      unless env['DNT'] == 1
        send_data(env)
      end
      @app.call(env)
    end

    private

    def send_data(env)
      ua_header = env['HTTP_USER_AGENT']
      user_agent = UserAgentParser.parse(ua_header)
      data = {
            "siteLocation": env['REQUEST_URI'],
            "siteReferrer": env['HTTP_REFERER'],
            "deviceName": user_agent.device.model,
            "deviceManufacturer": user_agent.device.brand,
            "osName": user_agent.os.family,
            "osVersion": user_agent.os.version.to_s,
            "browserName": user_agent.family,
            "browserVersion": user_agent.version.to_s
        }
      url = "https://#{@server}/domains/#{@domain_id}/records"
      Net::HTTP.post URI(url), data, "Content-Type" => "application/json"
    end
  end
end
