ActionController::Routing::Routes.draw do |map|
  map.connect 'events/backend', :controller => 'events', :action => 'backend'
  map.connect 'events/:id/registration', :controller => 'events', :action => 'registration'
  map.connect 'events/:eid/registrants', :controller => 'events', :action => 'registrants'
  map.connect 'events/:id/reg_conf', :controller => 'events', :action => 'registration_confirmation'
  map.connect 'events/register', :controller => 'events', :action => 'register'

  map.resources :attachments
  map.resources :entries
  map.resources :folders

  map.resources :events
  map.resources :sessions
  map.resources :resources
  map.login 'login', :controller => 'sessions', :action => 'new'
  map.logout 'logout', :controller => 'sessions', :action => 'destroy'
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # link_to(url_for(:controller => 'catalog', :action => 'view'))
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root(:controller => 'static_page', :action => 'frontpage')
  map.section(':section', :controller => 'static_page', :action => 'section')
  map.subsection(':section/:subsection', :controller => 'static_page', :action => 'section_page')


  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  # map.connect(':controller/:action/:id')
  # map.connect(':controller/:action/:id.:format')
end
