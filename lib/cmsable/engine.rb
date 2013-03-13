module Cmsable
  class Engine < ::Rails::Engine
    isolate_namespace Cmsable
    # This makes the consuming app load our helpers
    initializer 'cmsable.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        helper Cmsable::CmsableHelper
      end
    end
  end
end
