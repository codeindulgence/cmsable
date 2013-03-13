module Cmsable
  module CmsableHelper
    def cmsable name, options = {}

      options = {
        authorised:Cmsable.authorised
      }.merge options

      if options[:authorised]
        content_tag :div, Content.get(name).to_s.html_safe, id: :cmsable, contenteditable:true
      else
        Content.get(name).to_s.html_safe
      end

    end
  end
end
