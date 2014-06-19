# encoding: utf-8
module Cmsable
  # Cmsable view helpers
  module CmsableHelper
    def cmsable_assets
      javascript_include_tag('cmsable/application') +
      stylesheet_link_tag('cmsable/application')
    end

    DEFAULTS = {
      readonly: false, # Can edit by default
      rich: true,      # Use rich text editor by default
      plantext: false  # No text editor
    }

    def cmsable(name_or_model, options = {})
      model = get_model name_or_model

      options = DEFAULTS.merge options

      # Skip checking permission if set to readonly or
      # explicit authorisation is passed
      unless options.include?(:authorised) || options[:readonly]
        options[:authorised] = authorised?(model)
      end

      content = model.send(model.cmsable_body).html_safe
      editable = options[:authorised] && !options[:readonly]

      editable ? show_cmsable(content) : content
    end

    private

    def get_model(name_or_model)
      if name_or_model.class < ActiveRecord::Base
        name_or_model
      else
        Content.get(name_or_model)
      end
    end

    def show_cmsable(content)
      control = unless @cmsable_control_rendered
                  render template: 'cmsable/cmsable/control'
                end
      @cmsable_control_rendered = true
      id = "cmsable_edit_#{model.class.to_s.parameterize}_#{model.id}"
      content_tag(:div, content,
                  class: :cmsable_editor,
                  id: id,
                  'data-model' => model.class,
      ) + (control || '')
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
