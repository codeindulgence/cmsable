module CmsableHelper
  def cmsable *arguments
    model, name, options, attribute = [Cmsable.default_model, nil, {}, :body]
    arguments.each do |arg|
      case arg
        when Class  then model     = arg
        when String then name      = arg
        when Hash   then options   = arg
        when Symbol then attribute = arg
      end
    end
    options = {
      :editable  => Cmsable.editable
    }.merge options
    content = model.get(name)
    if options[:editable]
      content_tag :div, :class => :cmsable_node do
        concat content.send(attribute)
        concat link_to('Edit', content.edit_link, :class => :cmsable_begin_edit)
        concat(capture do
          form_for content do |form|
            concat form.text_area(:body, :class => :'ui-widget-content ui-corner-all')
          end
        end)
      end
    else
      content.send attribute
    end
  end
  def cmsable_includes
    capture do
      concat javascript_include_tag 'cmsable/cmsable'
      concat stylesheet_link_tag 'cmsable/cmsable'
    end
  end
end
