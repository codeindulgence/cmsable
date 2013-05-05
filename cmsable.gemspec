$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "cmsable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cmsable"
  s.version     = Cmsable::VERSION
  s.authors     = ["Nick Butler"]
  s.email       = ["nick@codeindulgence.com"]
  s.summary     = "Inline editing of page content"
  s.description = "Lets users update the content on their pages directly on the page without the need of an admin system"
  s.homepage    = "http://www.hardhatdigital.com.au/"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.11"
  s.add_dependency 'ckeditor', '~> 4.0.2'
  s.add_dependency 'cancan'

  s.add_development_dependency "sqlite3"
end
