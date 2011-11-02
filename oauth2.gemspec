$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "oauth2/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "oauth2"
  s.version     = Oauth2::VERSION
  s.authors     = ["Jais Cheema"]
  s.email       = ["jaischeema@gmail.com"]
  s.homepage    = "http://www.jaischeema.com"
  s.summary     = "Client Side Implementation of oauth2"
  s.description = "This gem provides the client side implementation of oauth2, with server side planned for future."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1.1"
  s.add_dependency "bcrypt-ruby"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
