Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
 # root to: "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'user_registration/sign_up'
  post 'user_registration/login'
  post 'admin_registration/login'
  get 'user_home/index'
  get 'user_registration/verify_confirmation_mail'
end
