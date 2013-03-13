module Cmsable
  module CmsableHelper
    def cmsable name, options = {}

      options = {
        authorised:Cmsable.authorised
      }.merge options

      if options[:authorised]
        content = Content.get(name)
        content_tag(:div, content, class: :cmsable_edit, id:"cmsable_edit_#{content.id}", contenteditable:true) +
        submit_tag('Save', class: :cmsable_save, id:"cmsable_save_#{content.id}")
      else
        Content.get(name).to_s.html_safe
      end

    end
  end
end
