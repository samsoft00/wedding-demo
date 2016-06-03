# class SubdomainConstraint
#   def self.matches?(request)
#     subdomains = %w{www admin administrator subdomain user admin demo}
#     request.subdomain.present? && !subdomains.include?(request.subdomain)
#   end
# end

Rails.application.routes.draw do
	
  as :user do
    patch '/user/confirmation' => 'confirmations#update', :via => :patch, :as => :update_user_confirmation
  end  

	devise_for :users, 
    :controllers => { 
      registrations: "registrations",
      confirmations: "confirmations" 
    }
    
  #Handle single pages
  match 'faqs', to: 'pages#faqs', via: [:get]
  match 'contact_us', to: 'pages#contact-us', via: [:get]

  devise_scope :user do
    # match 'vendor/sign_up', to: 'registrations#new', user: {user_type: 'vendor'}, via: [:get]
    # match 'wedding/sign_up', to: 'wedding/registrations#new', user: {user_type: 'wedding'}, via: [:get]
    match ':user_type/registration_successful', to: 'pages#registration_confirmation_page', as: 'registration_confirmation_page', via: [:get]
  end

  #users/:username/manage_listing <--- create
  scope '/users' do
    scope ':username' do
      resources :listings, path: :manage_listing, only: [:new, :create, :index, :edit, :update]
      resources :profiles, path: :settings, only: [:update, :edit]
    end   
  end

  # resources :listings, path_names: { edit: 'change' } do#, only: [:index, :show] #show all listing from various, search by listing
  #   member do
  #     get 'upload_images', to: 'listings#upload_images'
  #   end

  #   collection do
  #     get 'delete_image/:id', to: 'listings#delete_images', as: 'delete_image'
  #   end
  # end

  namespace :vendor do #show avater/logo, business/logo/username
    resources :profiles, only: [:create]
    resources :setup_store#, only: [:show, :update]
    resources :search, only: [:index] #find vendor
    
    root to: 'pages#vendor_homepage', controller: 'pages'

    scope '/categories' do
      get '/', to: 'categories#listing_categories', as: 'listing_categories'
      get ':category', to: 'categories#index'
    end    
  end

  #To start a wedding planing... select a template.
  # template => plan => register
  namespace :start do
    resources :wedding_plan, :path => '/'
  end

  # match 'start-planning', to: 'pages#start_planning', via: [:get]
  # match 'choose-plan', to: 'pages#choose-plan', via: [:get]

  namespace :wedding do

    resources :site_setup#, only: [:show, :update]
    scope ':username' do
      resources :settings, path: :backend#, only: [:index]
    end
    # resources :sites, path_names: { new: 'couple_info' }, only: [:new, :create] do
      # collection do
        # get 'select_template'
        # match 'our_story', to: 'sites#our_story', via: [:get, :post]
        # match 'wedding_location', to: 'sites#wedding_location', via: [:get, :post] #handle church and registry
        # get 'image_slider'
        # get 'gallery'
      # end
    # end

    #settings
  end

  root to: 'pages#index'

  # scope '/categories' do
  #   get '/', to: 'categories#listing_categories', as: 'listing_categories'
  #   get ':category', to: 'categories#index'
  # end

  resources :conversations, only: [:index] do
    collection do
      get :inbox
      get :sent
      get :trash      
      get ':username', to: 'conversations#show', as: 'show_user_conversation'
      post ':username', to: 'conversations#create', as: 'post_new_conversation'
    end
  end

  #:::::::::::::::::: Thinking of moving this to vendor vendor/:username/:slug
  get ":username", to: 'vendor/profiles#show', as: 'user_profile' # <-- See vendor and all works and profile info

  scope ":username" do #, to: 'profiles#show' # <-- See vendor and all works and profile info
    get ':id', to: 'listings#show', as: 'display_vendor_listing', only: [:show]
    post ':id/reviews', to: 'reviews#create', as: 'new_listing_review'
    # resources :reviews, only: [:create]
  end

end