Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'

  resources :wikis, only: [:show]
end
