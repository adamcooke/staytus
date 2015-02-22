Rails.application.routes.draw do

  namespace :admin do
    get 'login' => 'sessions#new'
    post 'login' => 'sessions#create'
    delete 'logout' => 'sessions#destroy'

    get 'settings' => 'settings#edit'
    patch 'settings' => 'settings#update'

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


  root 'pages#index'

end
