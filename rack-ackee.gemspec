# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.authors       = ["Matt Kozak"]
  gem.email         = ["matt@mkozak.pl"]
  gem.description   = %q{middleware reporting requests to Ackee, self-hosted analytics tool for those who care about privacy. Alternative to using the client-side JS tracker.}
  gem.summary       = %q{middleware reporting requests to Ackee, self-hosted analytics tool for those who care about privacy. Alternative to using the client-side JS tracker.}
  gem.homepage      = "https://github.com/meal/rack-ackee-middleware"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "rack-ackee"
  gem.require_paths = ["lib"]
  gem.version       = '0.1.2'

  gem.add_development_dependency('minitest')
  gem.add_development_dependency('rack-test')
  gem.add_runtime_dependency('rack')
  gem.add_runtime_dependency('user_agent_parser')
end
