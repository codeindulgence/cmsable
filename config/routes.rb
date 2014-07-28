Cmsable::Engine.routes.draw do
  put '/:id', :to => 'cmsable#update'
end
