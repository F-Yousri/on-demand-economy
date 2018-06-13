Rails.application.routes.draw do
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  get '/api/v1/orders/:page_number' , to: 'orders#show'
  post '/api/v1/orders' , to: 'orders#create'
  post '/api/v1/authentication/signin', to: 'authentication#authenticate'
  post '/api/v1/authentication/signup', to: 'users#create'
  put '/api/v1/authentication/update', to: 'users#update'
  post '/api/v1/authentication/verify' , to: 'users#verify'
  post '/api/v1/authentication/forgotpassword', to: 'users#forgot_password'
  post '/api/v1/authentication/resetpassword', to: 'users#reset_password'
  post '/api/v1/authentication/changepassword', to: 'users#change_password'
  get '/api/v1/providers', to: "providers#show"
  get '/api/v1/payments', to: "payments#show"
  post '/api/v1/payments' , to: 'payments#create'
end
