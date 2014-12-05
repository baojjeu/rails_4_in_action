Rails.application.routes.draw do


  namespace :admin do
    root 'base#index'
    resources :users
  end

  root 'projects#index'

  get 'signin' => 'sessions#new'
  post 'signin' => 'sessions#create'

  resources :users
  resources :projects do
    resources :tickets
  end
end