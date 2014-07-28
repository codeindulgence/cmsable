# encoding: utf-8
module Cmsable
# This makes the consuming app load our helpers
  class Engine < ::Rails::Engine
    isolate_namespace Cmsable
    initializer 'cmsable.action_controller' do |app|
      ActiveSupport.on_load :action_view do
        include Cmsable::CmsableHelper
      end
    end
  end
end
