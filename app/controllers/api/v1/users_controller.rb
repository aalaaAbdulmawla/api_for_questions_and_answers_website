class Api::V1::UsersController < ApplicationController
  before_action :authenticate_with_token!, only: [:update, :destroy, :my_tags]
	respond_to :json

	def index
		respond_with(User.all.page(params[:page]).per(6))
	end

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

	def update
	  user = current_user

	  if user.update(user_params)
	    render json: user, status: 200, location: [:api, user]
	  else
	    render json: { errors: user.errors }, status: 422
	  end
	end

	def destroy
	  current_user.destroy
	  head 204
	end

	def questions
		user = User.find(params[:id])
		respond_with(user.questions.page(params[:page]).per(6))
	end

	def answers
		user = User.find(params[:id])
		respond_with(user.answers.page(params[:page]).per(6))
	end

	def comments
		user = User.find(params[:id])
		respond_with(user.comments.page(params[:page]).per(6))
	end

	def favorites
		user = User.find(params[:id])
		respond_with(user.favorites.page(params[:page]).per(6))
	end

	def newest_questions
		user = User.find(params[:id])
		respond_with(user.questions.order(created_at: :desc).page(params[:page]).per(6))
	end

	def newest_answers
		user = User.find(params[:id])
		respond_with(user.answers.order(created_at: :desc).page(params[:page]).per(6))
	end

	def newest_votes
		user = User.find(params[:id])
		respond_with(user.votes.order(created_at: :desc).page(params[:page]).per(6))
	end

	def tags
		respond_with(User.tags(current_user))	
	end

	private
	def user_params
		params.require(:user).permit(:email, :password, :password_confiramtion, :first_name,
				:last_name, :job, :location, :about, :birth_date)
	end
end
