Cmsable::Engine.routes.draw do
  get '/:action', :to => 'cmsable'
  put '/:id', :to => 'cmsable#update'
end
