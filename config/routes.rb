Rails.application.routes.draw do

  root 'projects#index'
  get 'signin' => 'sessions#new'
  post 'signin' => 'sessions#create'
  delete 'signout' => 'sessions#destroy'

  namespace :admin do
    root 'base#index'
    resources :states do
      member do
        post :make_default
      end
    end
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