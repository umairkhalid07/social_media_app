class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :authenticate_user!
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :alias, :bio, :phone_number, :location, :birthday_at, :profile_photo, :email, :password, :password_confirmation)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :alias, :bio, :phone_number, :location, :birthday_at, :profile_photo, :email, :password, :current_password)}
  end
end
