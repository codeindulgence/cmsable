Cmsable::Engine.routes.draw do
  resources :contents, :only => :update
end
