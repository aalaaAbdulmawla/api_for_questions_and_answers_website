class Api::V1::AnswersController < ApplicationController
	before_action :authenticate_with_token!, only: [:create, :edit]
  respond_to :json

	def create
		answer = (Question.find(params[:question_id])).answers.build(answer_params)
		if answer.save
			#current_user.answers << answer
      render json: answer, status: 201, location: [:api, answer]
    else
      render json: { errors: answer.errors }, status: 422
    end
	end

	def update
    answer = current_user.answers.find(params[:id])
    if answer.update(answer_params)
      render json: answer, status: 200, location: [:api, answer]
    else
      render json: { errors: answer.errors }, status: 422
    end
  end

	def show
		respond_with Answer.find(params[:id])
	end


	private

  def answer_params
    params.require(:answer).permit(:body).merge(user_id: current_user.id)
  end
end
