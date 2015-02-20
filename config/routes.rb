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

    root 'dashboard#index'
  end

  root 'pages#index'

end
