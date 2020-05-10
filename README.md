# rack-ackee

> [Rack](https://github.com/rack/rack) middleware reporting requests to [Ackee](https://ackee.electerious.com/), self-hosted  analytics tool for those who care about privacy. Alternative to using the client-side JS tracker.

## Installation

Install gem

```
gem install rack-ackee
```

If you don't have the Ackee instance yet, you can quickly [deploy it on Heroku](https://docs.ackee.electerious.com/#/docs/Get%20started#with-heroku).

## Configuration with Rails

In your Gemfile

```
gem 'rack-ackee'
```

In your `config/application.rb`
```
config.middleware.use "Rack::Ackee", server: "https://myackeeserver.com", domain_id: "YOUR DOMAIN ID"
```

Remember to change the server and domain ID to your values.


