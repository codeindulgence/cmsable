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
        concat link_to('Edit', '#', :class => :cmsable_begin_edit)
        concat content.send(attribute)
        concat(capture do
          form_for content do |form|
            concat form.text_area(:body)
            concat submit_tag('Save')
          end
        end)
      end
    else
      content.send attribute
    end
  end
end
