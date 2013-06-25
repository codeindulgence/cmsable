module Cmsable
  module CmsableHelper

    def cmsable_assets
      javascript_include_tag('cmsable/application') +
      stylesheet_link_tag('cmsable/application')
    end

    def cmsable name_or_model, options = {}

      model = get_model name_or_model

      options = {
        readonly:false
      }.merge options

      # Skip checking permission of set to readonly or
      # explicit authorisation is passed
      unless options.include?(:authorised) or options[:readonly]
        options[:authorised] = authorised?(model)
      end

      content_or_editable_content model, (options[:authorised] and !options[:readonly])

    end

  private

    def get_model name_or_model
      if name_or_model.class < ActiveRecord::Base
        name_or_model
      else
        Content.get(name_or_model)
      end
    end

    def content_or_editable_content model, editable
      control = if(!@cmsable_control_rendered and editable)
        render :template => 'cmsable/cmsable/control'
      end
      @cmsable_control_rendered = true
      content = model.send(model.cmsable_body).html_safe
      if editable
        content_tag(:div, content, {
                    class: :cmsable_editor,
                       id: "cmsable_edit_#{model.class.to_s.parameterize}_#{model.id}",
          :'data-model' => model.class,
        }) + (control or '')
      else
        content
      end
    end

    def authorised? model
      authorised = false
      if Cmsable.const_defined? :CanCan
        authorised = can? :update, model
      else
        authorised = Cmsable.authorised
      end
    end

  end
end
