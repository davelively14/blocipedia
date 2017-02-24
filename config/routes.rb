Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'

  resources :wikis
  resources :charges, only: [:new, :create, :destroy]
  resources :users, only: [:show]
  resources :collaborators, only: [:create, :destroy]
end
