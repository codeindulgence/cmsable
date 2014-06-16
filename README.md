# Cmsable

Add inline editable content to pages.

Installation:

Add to your Gemfile
  gem 'cmsable'

Get Dependencies
  bundle install

Add to your routes
  mount Cmsable::Engine => '/cmsable'

Install and run the migrations if you want to use the built in model
  rake cmsable:install:migrations
  rake db:migrate

Cmsable uses CanCan so make sure this is setup in your necessary controller(s)
If your users aren't called users then you'll get something like:
  undefined local variable or method `current_user' for ...

You need to define the current_ability, e.g.
  def current_ability
    @current_ability ||= AccountAbility.new(current_account)
  end
From https://github.com/ryanb/cancan/wiki/changing-defaults

Usage:

In your layout
  <%= cmsable_assets %>

To use the built in model
  In your view files
    <%= cmsable 'identifier' %>

Identifier can be anything, for example 'Homepage Intro' or something

To use existing models
  Add to your model
    cmsable :body => :column_to_use_for_content
  Then in your views
    <%= cmsable @model_instance %>

## TODO
  - Handle saving errors
  - Remove CanCan dependancy
  - Decouple ckeditor
  - Support different editors
  - Setup config initializer for added customizability
  - Add plain text mode
  - Add file mode
  - Add image mode
  - Add video mode (youtube/vimeo/etc)
  - Fix highlight so empty areas are still visible
