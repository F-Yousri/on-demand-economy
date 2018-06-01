Rails.application.routes.draw do
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :orders
  resources :providers
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
  get 'test' , to: 'users#test'
  post 'verify' , to: 'users#verify'
  post 'forgot_password', to: 'users#forgot_password'
  post 'reset_password', to: 'users#reset_password'
end
