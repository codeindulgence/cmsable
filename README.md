# Cmsable
---------

Add inline editable content to pages.

## Installation

Add to your Gemfile

```ruby
gem 'cmsable'
```

Get Dependencies

    bundle install

Add to your routes

```ruby
  mount Cmsable::Engine => '/cmsable'
```

Install and run the migrations if you want to use the built in model

    rake cmsable:install:migrations
    rake db:migrate

Cmsable uses CanCan so make sure this is set up in your necessary controller(s)
If your users aren't called users then you'll get something like:

    undefined local variable or method `current_user' for ...

You need to define the current_ability, e.g.

```ruby
def current_ability
  @current_ability ||= AccountAbility.new(current_account)
end
```
(From https://github.com/ryanb/cancan/wiki/changing-defaults)

## Usage

### To use the built in model
In your view files

```ruby
<%= cms 'identifier' %>
```

Identifier can be any string or symbol, for example `'Homepage Intro'` or `:something`

For plain text areas pass `type: :plain` as an option.
This way you can put content in any tag you want without worrying about users
messing up the markup.

```ruby
<span><%= cms :identifier, type: :plain %></span>
```

The problem with the above is that in edit mode you'll end up with invalid HTML:

```html
<span><div contenteditable>Content</div></span>
```

To avoid this you can override the tag used in edit mode:

```ruby
<%= cms :identifier, type: :plain, tag: 'span' %>
```
Resulting in:
```html
<span contenteditable>Content</span>
```

### To use your own models
Add to your model:

```ruby
cms :body => :column_to_use_for_content
```

Then in your views:
```ruby
<%= cms @model_instance %>
```

## TODO
  - Allow classes on custom tags
  - Fix highlight so empty areas are still visible
  - Add image mode
  - Add file mode
  - Add video mode (youtube/vimeo/etc)
  - Add support for langs/i18n
  - Handle saving errors
  - Decouple ckeditor
  - Support different editors
  - Remove CanCan dependancy
  - Setup config initializer for added customizability
