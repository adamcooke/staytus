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
    resources :locations
    resources :service_statuses
    resources :issues do
      get 'resolved', :on => :collection
      resources :issue_updates
    end

    root 'dashboard#index'
  end

  root 'pages#index'

end
