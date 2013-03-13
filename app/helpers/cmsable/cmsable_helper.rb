module Cmsable
  module CmsableHelper

    def cmsable_assets
      javascript_include_tag('cmsable/application') +
      stylesheet_link_tag('cmsable/application')
    end

    def cmsable name, options = {}

      options = {
        authorised:authorised?
      }.merge options

      if options[:authorised]
        content = Content.get(name)
        content_tag(:div, content, class: :cmsable_edit, id:"cmsable_edit_#{content.id}", contenteditable:true) +
        submit_tag('Save', class: :cmsable_save, id:"cmsable_save_#{content.id}")
      else
        Content.get(name).to_s.html_safe
      end

    end

  private

    def authorised?
      authorised = false
      if Cmsable.const_defined? :CanCan
        authorised = can? :update, Content
      else
        authorised = Cmsable.authorised
      end
    end

  end
end
