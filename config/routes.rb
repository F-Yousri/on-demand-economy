Rails.application.routes.draw do
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  get '/api/v1/orders/:page_number' , to: 'orders#show'
  post '/api/v1/orders' , to: 'orders#create'
  post '/api/v1/authentication/signin', to: 'authentication#authenticate'
  post '/api/v1/authentication/signup', to: 'users#create'
  put '/api/v1/authentication/update', to: 'users#update'
  get '/api/v1/authentication/show', to: 'users#show'
  patch '/api/v1/authentication/verify' , to: 'users#verify'
  post '/api/v1/authentication/resendverification' , to: 'users#resend_verification'
  post '/api/v1/authentication/forgotpassword', to: 'users#forgot_password'
  get '/api/v1/authentication/mobile/resetpassword', to:'users#reset_password_mob'
  patch '/api/v1/authentication/resetpassword', to: 'users#reset_password'
  patch '/api/v1/authentication/changepassword', to: 'users#change_password'
  get '/api/v1/providers', to: "providers#show"
  get '/api/v1/payments', to: "payments#show"
  post '/api/v1/payments' , to: 'payments#create'
  get '/api/v1/about', to: "users#about_us"

  # https://driveo.herokuapp.com/api/v1/authentication/resetpassword?hash=#{@reset_token}
end
