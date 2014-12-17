Rails.application.routes.draw do

  root 'projects#index'
  get 'signin' => 'sessions#new'
  post 'signin' => 'sessions#create'
  delete 'signout' => 'sessions#destroy'

  namespace :admin do
    root 'base#index'
    resources :users do
      resources :permissions
      put 'permissions', to: 'permissions#set',
                         as: 'set_permissions'
    end
  end

  resources :users
  resources :projects do
    resources :tickets
  end
  resources :tickets do
    resources :comments
  end
  resources :files
end