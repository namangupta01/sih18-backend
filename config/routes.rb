Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
 # root to: "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'user_registration/sign_up'
  # request params
  # 	{
  # 		"email": "value"
  # 		"password": "value"
  # 		"phone_number": "value"
  # 		"name" : "value"
  # 	}
  post 'user_registration/login'
  post 'admin_registration/login'
  post 'user_home/index'
  get 'user_registration/verify_confirmation_mail'
  get 'user_home/dams'
  post 'user_home/update_user_dam_details'
  post 'user_home/notifications'
  post 'user_home/all_notifications'
  post 'user_home/help_me'
  post 'user_home/dam_sphefic_directory'
  post 'user_home/dam_directory'
  post 'admin_home/update_water_release'
  post 'admin_home/dam_water_release_detail'

  post 'admin_registration/forgot_password'
end
