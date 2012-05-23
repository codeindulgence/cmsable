module CmsableHelper
  mattr_accessor :cmsable_editable, :default_model
  @@cmsable_editable = false
  def cmsable *arguments
    model, name, options, attribute = [default_model, nil, {}, :body]
    arguments.each do |arg|
      case arg
        when Class  then model     = arg
        when String then name      = arg
        when Hash   then options   = arg
        when Symbol then attribute = arg
      end
    end
    options = {
      :editable  => false
    }.merge options
    if options[:editable] or cmsable_editable
      model.get(name).send(attribute)+' edit!'
    else
      model.get(name).send attribute
    end
  end
end
