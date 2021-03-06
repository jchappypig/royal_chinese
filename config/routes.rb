RoyalChinese::Application.routes.draw do

  resources :posts do
    member do
      put 'broadcast'
    end
    collection do
      get 'search'
    end
  end

  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }

  resources :menus do
    resources :favorites, only: [:create]
    collection do
      get 'download'
      get 'search'
    end
  end
  resources :followers, only: [:index, :destroy] do
    collection do
      post 'subscribe'
      get 'unsubscribing'
      post 'unsubscribe'
      get 'search'
    end
  end

  root to: 'followers#new'
  get 'our_location',  to: 'home#our_location'
  get 'our_menu', to: 'home#our_menu'
  get 'admin', to: 'home#admin', as: :user_root

  match '/404', to: 'errors#not_found'
  match '/500', to: 'errors#internal_server_error'
  match '/422', to: 'errors#unprocessable_entity_error'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
