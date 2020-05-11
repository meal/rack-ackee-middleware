require 'net/http'
require 'user_agent_parser'

module Rack
  class Ackee

    def initialize(app, options={})
      @app = app
      @server = options[:server]
      @domain_id = options[:domain]
      puts options
    end

    def call(env)
      unless env['DNT'] == 1
        puts "Server #{@server}"
        send_data(env)
        status, headers, response = @app.call(env)
        [status, headers, response]
      else
        status, headers, response = @app.call(env)
        [status, headers, response]
      end
    end

    private

    def send_data(env)
      ua_header = env['HTTP_USER_AGENT']
      user_agent = UserAgentParser.parse(ua_header)
      req = Rack::Request.new(env)
      data = {
            "siteLocation": req.url,
            "siteReferrer": env['HTTP_REFERER'],
            "deviceName": user_agent.device.model,
            "deviceManufacturer": user_agent.device.brand,
            "osName": user_agent.os.family,
            "osVersion": user_agent.os.version.to_s,
            "browserName": user_agent.family,
            "browserVersion": user_agent.version.to_s
        }.to_json
      url = "#{@server}/domains/#{@domain_id}/records"
      puts url
      Net::HTTP.post URI(url), data, "Content-Type" => "application/json"
    end
  end
end
  