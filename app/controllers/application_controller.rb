class ApplicationController < ActionController::Base
  # devise is weird and uses :authentication_keys for several
  # RegistrationsController actions (#create, #udpate)
  # https://github.com/plataformatec/devise/blob/master/lib/devise/parameter_sanitizer.rb
  # def attributes_for(kind)
  #   case kind
  #   when :sign_in
  #     auth_keys + [:password, :remember_me]
  #   when :sign_up
  #     auth_keys + [:password, :password_confirmation]
  #   when :account_update
  #     auth_keys + [:password, :password_confirmation, :current_password]
  #   end
  # end
  before_action :configure_permitted_parameters, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :email
    devise_parameter_sanitizer.for(:account_update) << :email
  end
end
