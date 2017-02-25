require 'api_constraints'
Rails.application.routes.draw do
  get 'rent/index'

  mount Rich::Engine => '/rich', :as => 'rich'
  devise_for :users
  get 'welcome/index'
  root 'welcome#index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  
  namespace :api, defaults: { format: :json } do
    scope module: :v1,
            constraints: ApiConstraints.new(version: 1, default: true) do
      # We are going to list our resources here
      post 'rents/rent_room' => 'rents#rent_room'
      post 'rents/free_room' => 'rents#free_room'
      post 'rents/pay_rent' => 'rents#pay_rent'
      post 'rents/pay_secure' => 'rents#pay_secure'
      post 'login_api' => 'users#login_api'
    end
  end

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
