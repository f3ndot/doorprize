Doorprize::Application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: :omniauth_callbacks }
  resources :witnesses

  resources :cars

  resources :incidents do
    member do
      get 'assign-score', to: 'incidents#edit_override_score', as: :edit_override_score
      patch 'assign-score', to: 'incidents#update_override_score', as: :update_override_score
    end
    collection do
      get 'sort/:sort', to: 'incidents#index', as: :sorted
      get 'sort/:sort/:user', to: 'incidents#index', as: :byuser_sorted
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'incidents#index'

  post 'dismiss-survey' => 'surveys#dismiss', as: :survey
  get 'robots.txt' => 'pages#robots'
  get 'privacy' => 'pages#privacy', as: :privacy
  get 'terms' => 'pages#terms', as: :terms
  get 'prelaunch' => 'pages#prelaunch', as: :prelaunch
  get 'why' => 'pages#why', as: :why
  post 'feedback' => 'pages#feedback', as: :feedback


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
