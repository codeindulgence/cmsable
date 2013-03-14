module Cmsable
  module CmsableHelper

    def cmsable_assets
      javascript_include_tag('cmsable/application') +
      stylesheet_link_tag('cmsable/application')
    end

    def cmsable name_or_model, options = {}

      model = get_model name_or_model

      options = {
        authorised:authorised?(model)
      }.merge options

      content_or_editable_content model, options[:authorised]

    end

  private

    def get_model name_or_model
      if name_or_model.class < ActiveRecord::Base
        name_or_model
      else
        Content.get(name_or_model)
      end
    end

    def element_id type, model
      "cmsable_#{type}_#{model.class.to_s.parameterize}_#{model.id}"
    end

    def button model
      submit_tag('Save', {
        class: :cmsable_save,
           id: element_id(:save, model),
           :'data-model' => model.class,
           :'data-token' => form_authenticity_token
      })
    end

    def content_or_editable_content model, authorised
      control = render :template => 'cmsable/cmsable/control' unless @control_rendered
      @control_rendered = true
      content = model.send(model.cmsable_body).html_safe
      if authorised
        content_tag(:div, content, {
          contenteditable: true,
                    class: :cmsable_edit,
                       id: element_id(:edit, model),
        }) + button(model) + (control or '')
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
