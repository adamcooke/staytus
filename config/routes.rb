Rails.application.routes.draw do

  namespace :admin do
    get 'login' => 'sessions#new'
    post 'login' => 'sessions#create'
    delete 'logout' => 'sessions#destroy'

    get 'settings' => 'settings#edit'
    patch 'settings' => 'settings#update'
    get 'settings/design' => 'settings#design'

    get 'infrastructure' => 'infrastructure#index'

    resources :users
    resources :services
    resources :service_statuses
    resources :issues do
      get 'resolved', :on => :collection
      resources :issue_updates
    end
    resources :maintenances do
      get 'completed', :on => :collection
      post 'toggle', :on => :member
      resources :maintenance_updates
    end
    get 'helpers/:action', :controller => 'helpers'
    root 'dashboard#index'
  end

  get 'issue/:id' => 'pages#issue'
  get 'maintenance/:id' => 'pages#maintenance'
  get 'history' => 'pages#history'

  get 'robots.txt' => 'pages#robots'
  root 'pages#index'

end
