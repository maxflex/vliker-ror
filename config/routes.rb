Rails.application.routes.draw do

  # resources :gift_codes
  get 'user/user_id'

  mount RailsAdmin::Engine => '/mer', as: 'rails_admin'

  controller :tasks do
    post 'blocks'   => :blocks
    post 'get_new'  => :get_new
    post 'stop'     => :stop
    post 'stats'    => :stats
  end

  resource :tasks, only: [] do
    get :all
    post :stop_task
  end

  resource :goods, controller: 'store', only: [] do
    get :all
  end

  resource :gift_codes, only: [] do
    post :check
  end

  resource :reviews, only: [] do
    post :getReviews
  end

  resources :reviews

  resource :payments, only: [] do
    post 'yandex'
    post 'webmoney'
  end

  controller :users, only: [] do
    get 'user_id'
    post :check_vip
  end

  # resources :tasks, only: [] do
  #   post 'blocks'
  #   post 'get_new'
  #   post 'stop'
  # end

  root 'main#index'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

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
