Rails.application.routes.draw do

  get "view_file/show"

  resources :instances do
    member do
      get 'preservation'
      patch 'update_preservation_profile'
      get 'administration'
      patch 'update_administration'
    end
  end
  resources :works do
    resources :instances do
      get 'send_to_preservation', on: :member
    end
    resources :trykforlaegs
    post 'aleph', on: :collection
  end

  resources :content_files, :except => [:new, :index, :delete, :create, :edit, :show, :update, :destroy] do
    member do
      get 'download'
    end
  end
  root to: 'catalog#index'
  # namespace for managing system
  namespace :administration do
    resources :controlled_lists
    resources :activities
  end

  blacklight_for :catalog
  devise_for :users

  namespace :authority do
    resources :people
  end

  get 'resources/:id' => 'resources#show'

  # The priority is based upon order of creation:
  # first created -> highest priority.
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
