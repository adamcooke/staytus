Rails.application.routes.draw do

  namespace :admin do
    get 'login' => 'sessions#new'
    post 'login' => 'sessions#create'
    delete 'logout' => 'sessions#destroy'

    root 'dashboard#index'
  end

end
