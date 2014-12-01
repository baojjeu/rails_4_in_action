Rails.application.routes.draw do
  get 'users/new'

  get 'users/show'

  root 'projects#index'

  resources :users
  resources :projects do
    resources :tickets
  end
end