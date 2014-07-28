# encoding: utf-8
module Cmsable
  # Cmsable view helpers
  module CmsableHelper
    def cmsable_assets
      javascript_include_tag('cmsable/application') +
      stylesheet_link_tag('cmsable/application')
    end

    TYPES = [
      :rich, # CKEditor (default)
      :plain # Nothing fancy
    ]

    DEFAULTS = {
      readonly: false, # Can edit by default
      type: :rich,      # Use rich text editor by default
      plantext: false,  # No text editor
      tag: nil # What tag to use for contenteditable
    }

    def cms(name_or_model, options = {})
      model = get_model name_or_model

      options = DEFAULTS.merge options

      # Fail on unknow types
      type_fail options[:type] unless TYPES.include? options[:type]

      # Skip checking permission if set to readonly or
      # explicit authorisation is passed
      readonly = options.include?(:authorised) || options[:readonly]
      options[:authorised] = authorised?(model) unless readonly

      content = model.send(model.cmsable_body).html_safe
      editable = options[:authorised] && !options[:readonly]

      editable ? show_cmsable(content, model, options) : uncmsable(content, options[:tag])
    end

    private

    def type_fail(type)
      fail "Unknown cmsable type: #{type}." + "Must be one of #{TYPES * ', '}"
    end

    def get_model(name_or_model)
      if name_or_model.class < ActiveRecord::Base
        name_or_model
      else
        Content.get(name_or_model)
      end
    end

    def show_cmsable(content, model, options)
      control = unless @cmsable_control_rendered
                  render template: 'cmsable/cmsable/control'
                end
      @cmsable_control_rendered = true
      id = "cmsable_edit_#{model.class.to_s.parameterize}_#{model.id}"
      content_tag((options[:tag] || :div), content,
                  class: "cmsable_editor cmsable_#{options[:type]}",
                  id: id,
                  'data-model' => model.class,
      ) + (control || '')
    end

    def uncmsable(content, tag)
      if tag
        content_tag tag, content
      else
        content
      end
    end

    def authorised?(model)
      if Cmsable.const_defined? :CanCan
        can? :update, model
      else
        Cmsable.authorised
      end
    end
  end
end
