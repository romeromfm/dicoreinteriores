Rails.application.routes.draw do
  get 'stylesheets/theme', as: 'theme_css'

  root 'home#index'

  get '/blog' => 'blog#index'
  get '/blog/:id' => 'blog#show', as: 'post'
  get '/blog/tag/:tag' => 'blog#tag', as: 'tag'
  get '/blog/posts/category/:category' => 'blog#by_category', as: 'by_category'
  get '/blog/posts/month/:month' => 'blog#by_month', as: 'by_month'

  # devise_for :users

  namespace :admin do
    get '/', to: redirect('/admin/posts')
    resources :posts
    resources :categories, except: [:show]
    resources :assets
    resources :users
    resources :admins, controller: 'users', only: [:create, :update, :new, :edit], type: 'admin'
    resources :customers, controller: 'users', only: [:create, :update, :new, :edit], type: 'customer'
    resources :configurations, except: [:index]
    resources :preferences
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }

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
