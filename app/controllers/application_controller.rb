class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  default_form_builder BulmaFormBuilder

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :first_name, :middle_name, :last_name, :city, :country, :biography, :image) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password, :first_name, :middle_name, :last_name, :city, :country, :biography, :image) }
    
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
