Rails.application.routes.draw do

  namespace :admin do
    #
    # Authentication
    #
    get 'login' => 'sessions#new'
    post 'login' => 'sessions#create'
    delete 'logout' => 'sessions#destroy'

    # Settings
    #
    get 'settings' => 'settings#index'
    get 'settings/general' => 'settings#edit'
    patch 'settings' => 'settings#update'
    get 'settings/design' => 'settings#design'
    resources :users
    resources :services
    resources :service_statuses
    resources :service_groups
    resources :email_templates, :only => [:index, :edit, :update, :destroy]
    resources :api_tokens

    #
    # Issues
    #
    resources :issues do
      get 'resolved', :on => :collection
      resources :issue_updates
    end

    #
    # Maintenances
    #
    resources :maintenances do
      get 'completed', :on => :collection
      post 'toggle', :on => :member
      resources :maintenance_updates
    end

    #
    # Subscribers
    #
    resources :subscribers, :only => [:index, :destroy, :new, :create] do
      post 'verify', :on => :member
    end

    #
    # Misc. Admin Routes
    #
    get 'helpers/:action', :controller => 'helpers'

    #
    # Admin Root
    #
    root 'dashboard#index'
  end

  #
  # Setup Wizard
  #
  match 'setup/:action', :controller => 'setup', :as => 'setup', :via => [:get, :post]

  #
  # Public Site Paths
  #
  get 'issue/:id' => 'pages#issue'
  get 'maintenance/:id' => 'pages#maintenance'
  get 'history' => 'pages#history'
  get 'robots.txt' => 'pages#robots'
  get 'subscribe' => 'pages#subscribe'
  post 'subscribe/email' => 'pages#subscribe_by_email'
  get 'unsub/:token' => 'pages#unsubscribe'
  get 'verify/:token' => 'pages#subscriber_verification'
  root 'pages#index'

end
