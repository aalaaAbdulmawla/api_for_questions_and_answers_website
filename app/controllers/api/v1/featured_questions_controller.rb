class Api::V1::FeaturedQuestionsController < ApplicationController
	before_action :authenticate_with_token!, only: [:create]
	before_action :check_bounty
	respond_to :json

	def create
		featured_question = FeaturedQuestion.new(featured_question_params)
		if featured_question.save
			Resque.enqueue_at(featured_question.duration.days.from_now, FeaturedBounty, 
				current_user.id, featured_question.question_id)
			current_user.update(experience: current_user.experience - featured_question.bounty)
			render json: { body: {
												user_id: current_user.id, question_id: featured_question.question_id, 
												duration: featured_question.duration, bounty: featured_question.bounty}
											}, status: 201
	  else
	    render json: { errors: featured_question.errors }, status: 422
	  end
	end

	def show
	
	end



	private
	def featured_question_params
    params.require(:featured_question).permit(:bounty, :duration).merge(user_id: current_user.id, 
    																															question_id: params[:question_id])
  end

  def check_bounty
  	if current_user.experience <= params[:featured_question][:bounty]
  		render json: { errors: "Bounty must be less than or equal to your experience." }, status: 422
  		return false
  	end
  end

end
