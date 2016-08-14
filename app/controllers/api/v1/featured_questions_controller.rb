class Api::V1::FeaturedQuestionsController < ApplicationController
	before_action :authenticate_with_token!, only: [:create]
	before_action :check_bounty
	respond_to :json

	def create
		featured_question = FeaturedQuestion.new(featured_question_params)
		if featured_question.save
			render json: featured_question, status: 201, location: [:api, featured_question]
	  else
	    render json: { errors: featured_question.errors }, status: 422
	  end
	end

	def show
		respond_with FeaturedQuestion.find(params[:id])
	end



	private
	def featured_question_params
    params.require(:featured_question).permit(:bounty, :duration).merge(user_id: current_user.id, 
    																															question_id: params[:question_id])
  end

  def check_bounty
  	current_user.experience >= params[:bounty]
  end

end
