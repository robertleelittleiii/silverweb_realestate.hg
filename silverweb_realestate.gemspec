$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "silverweb_realestate/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "silverweb_realestate"
  s.version     = SilverwebRealestate::VERSION
  s.authors     = ["Robert Lee Little III"]
  s.email       = ["rob@silverwebsystems.com"]
  s.homepage    = "http://www.silverwebsystems.com/"
  s.summary     = "This is a realestate gem that plugs into the silverweb cms gem."
  s.description = "Will create a series of models (realator, propoerty, etc) for the realestate rets web protocol"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.6"
  s.add_dependency 'silverweb_cms'
  s.add_dependency 'rets'
end
