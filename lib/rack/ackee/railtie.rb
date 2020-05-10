module Rack

  class Ackee::Railtie < Rails::Railtie
    initializer "rack.ackee.initializer" do |app|
      app.middleware.insert 0, Rack::Ackee
    end
  end

end
