class Api::V1::UsersController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:show, :create]
	respond_to :json

	def show
		respond_with User.find(params[:id])
	end

	def create
		user = User.new(user_params)
		if user.save
			render json: user, status: 201, location: [:api, user]
		else
			render json: { errors: user.errors }, status: 422
		end
	end

	private
	def user_params
		params.require(:user).permit(:email, :password, :password_confiramtion, :first_name,
				:last_name, :job, :location, :about, :birth_date)
	end
end
