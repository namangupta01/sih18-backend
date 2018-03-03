Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'user_registration/sign_up'
  post 'user_registration/login'
  post 'admin_registration/login'
end
