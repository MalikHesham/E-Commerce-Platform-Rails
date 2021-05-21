Rails.application.routes.draw do
  resources :carts
  resources :orders

  root to: "products#index"

  resources :coupons
  resources :stores
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :products
  resources :brands
  resources :categories
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
