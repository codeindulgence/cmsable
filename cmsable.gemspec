# encoding: utf-8
$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'cmsable/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'cmsable'
  s.version     = Cmsable::VERSION
  s.authors     = ['Nick Butler']
  s.email       = ['nick@codeindulgence.com']
  s.summary     = 'Inline editing of page content'
  s.description = 'Lets users update the content on their pages directly on the page without the need of an admin system'
  s.homepage    = 'https://github.com/codeindulgence/cmsable'

  s.files = Dir['{app,config,db,lib}/**/*'] + ['MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']
  s.licenses = ['MIT']

  s.add_dependency 'rails', '~> 4.0'
  s.add_dependency 'ckeditor', '~> 4.0'
  s.add_dependency 'cancan', '~> 1.6'

  s.add_development_dependency 'sqlite3', '~> 1.6'
end
