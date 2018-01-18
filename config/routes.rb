Rails.application.routes.draw do
  root 'welcome#index'
  post 'users/login'
  get 'users/logout'
  resources :invoices
  resources :orders
  resources :items
  resources :categories
  resources :users
end
