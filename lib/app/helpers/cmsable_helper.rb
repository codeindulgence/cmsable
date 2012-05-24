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
    if options[:editable]
      model.get(name).send(attribute)+' edit!'
    else
      model.get(name).send attribute
    end
  end
end
