Rails.application.routes.draw do
  get "hashtags/:hashtag",   to: "hashtags#show",      as: :hashtag
  # get "hashtags",            to: "hashtags#index",     as: :hashtags
  resources :likes
  resources :jobs do
    member do
      get :my_applied_jobs
      post :my_jobs
      post :post_jobs
    end
    collection do
      get :search_job
      get :search_cvs
      get :suitable_bnv_for_jobs
    end
  end
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :posts do
    get :post_comment, on: :member
    get :view_activity, on: :collection
    get :share, on: :member
    get :who_shares, on: :member
    resources :attachments, :only => [:create]
  end

  resources :comments, only: [:create, :destroy]
  devise_for :users

  resources :events do
    collection do
      get :calendar
    end
  end

  resources :news do
  end

  resources :facilities

  resources :facility_forms do
     get :download, on: :member
  end

  resources :galleries do
    get :album_wise_photos, on: :member
  end

  resources :page_banners do

  end

  authenticated :user do
    root to: 'home#index', as: 'home'
  end
  unauthenticated :user do
    root 'home#front'
  end

  get '/search', to: 'home#search', as: :search
  get '/forms', to: 'home#forms', as: :forms
  get '/photo-gallery', to: 'home#photo_gallery', as: :photo_gallery
  get '/news-and-event', to: 'home#news_and_event', as: :news_and_event
  get '/contact', to: 'home#contact', as: :contact
  get '/former-cns', to: 'home#former_cns', as: :former_cns
  get '/bnchsl-form', to: 'home#bnchsl_form', as: :bnchsl_form
  get '/bnbf-form', to: 'home#bnbf_form', as: :bnbf_form
  get '/education-grant-form', to: 'home#education_grant_form', as: :education_grant_form
  get '/financial-grant-form', to: 'home#financial_grant_form', as: :financial_grant_form
  get '/armed-form-service', to: 'home#armed_form_service', as: :armed_form_service
  get '/sena-kallyan-facilities-form', to: 'home#sena_kallyan_facilities_form', as: :sena_kallyan_facilities_form
  get '/chief-more', to: 'home#chief_more', as: :chief_more
  get '/bnchsl-more', to: 'home#bnchsl_more', as: :bnchsl_more
  get '/bnbf-more', to: 'home#bnbf_more', as: :bnbf_more
  get '/education-grant-more', to: 'home#education_grant_more', as: :education_grant_more
  get '/financial-grant-more', to: 'home#financial_grant_more', as: :financial_grant_more
  get '/armed-services-more', to: 'home#armed_services_more', as: :armed_services_more
  get '/sena-kallyan-sangstha-more', to: 'home#sena_kallyan_sangstha_more', as: :sena_kallyan_sangstha_more
  get '/event-single', to: 'home#event_single', as: :event_single
  post '/contact-submit', to: 'home#contact_submit', as: :contact_submit
  get '/email-template', to: 'home#email_template', as: :email_template
  get '/email_temoplate', to: 'home#email_temoplate', as: :email_temoplate

  match :follow, to: 'follows#create', as: :follow, via: :post
  match :unfollow, to: 'follows#destroy', as: :unfollow, via: :post
  get :my_followers, to: 'follows#index', as: :my_followers
  #match :like, to: 'likes#create', as: :like, via: :post
  #match :unlike, to: 'likes#destroy', as: :unlike, via: :post
  match :find_friends, to: 'home#find_friends', as: :find_friends, via: :get
  match :about, to: 'home#about', as: :about, via: :get

  resources :messages do
  get :live_search, on: :collection
  end

  resources :notifications do

  end

  get '/:id', to: 'users#show'
  resources :users do
    member do
      get :friends
      get :followers
      get :deactivate
      get :mentionable
      post :post_job
      get :show_profile
      delete :delete_cover_img
      delete :delete_profile_img
      get :calculate_count
      get :cover_and_profile_photo_update
    end
    collection do
      get :select_rank
      get :cv_upload
      post :doc_upload
      get :search_user
      get :find_people
      get :search_recent_users
      post :check_status
    end
  end

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