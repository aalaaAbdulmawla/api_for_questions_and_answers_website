class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
 # before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  include ActionController::Caching::Pages
  self.page_cache_directory = "#{Rails.root.to_s}/public/page_cache"
  
  def configure_permitted_parameters
  	devise_parameter_sanitizer.permit(:sign_up, :account_update) do |user_params|
    	user_params.permit(:first_name, :last_name, :email, :password, 
    										 :password_confirmation, :birth_date, :location, :job, :about)
  	end
  end

  protected
  
  def current_user
    @current_user ||= User.find_by(auth_token: request.headers['Authorization'])
  end

  def authenticate_with_token!
    render json: { errors: "Not authenticated" },
                status: :unauthorized unless user_signed_in?
  end

  def user_signed_in?
    current_user.present?
  end

end
