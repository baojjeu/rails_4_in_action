Rails.application.routes.draw do


  namespace :admin do
    root 'base#index'
    resources :users do
      resources :permissions

      put 'permissions', to: 'permissions#set',
                         as: 'set_permissions'
    end
  end

  root 'projects#index'

  get 'signin' => 'sessions#new'
  post 'signin' => 'sessions#create'

  resources :users
  resources :projects do
    resources :tickets
  end
end