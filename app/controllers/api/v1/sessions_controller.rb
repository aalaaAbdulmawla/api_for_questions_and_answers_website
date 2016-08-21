class Api::V1::SessionsController < ApplicationController
	#skip_before_filter :authenticate_user!, :only => [:create]

  api! "Creates a new session."
	def create
    user_password = params[:session][:password]
    user_email = params[:session][:email]
    user = user_email.present? && User.find_by(email: user_email)

    if user.valid_password? user_password
      sign_in user, store: false
      user.generate_authentication_token!
      user.save
      render json: {body: {auth_token: user.auth_token}}, status: 200, location: [:api, user]
    else
      render json: { errors: "Invalid email or password" }, status: 422
    end
  end

  api! "Deletes current user 's session [auth required]"
  def destroy
    user = User.find_by(auth_token: params[:id])
    user.generate_authentication_token!
    user.save
    head 204
  end
end
