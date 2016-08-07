class Api::V1::QuestionsController < ApplicationController
	before_action :authenticate_with_token!, only: [:create, :update]
	respond_to :json

	def index
		respond_with Question.all
	end

	def show
		respond_with Question.find(params[:id])
	end

	def create
    question = current_user.questions.build(question_params)
    if question.save
      render json: question, status: 201, location: [:api, question]
    else
      render json: { errors: question.errors }, status: 422
    end
  end

  def update
    question = current_user.questions.find(params[:id])
    if question.update(question_params)
      render json: question, status: 200, location: [:api, question]
    else
      render json: { errors: question.errors }, status: 422
    end
  end

  def destroy
    question = current_user.questions.find(params[:id])
    question.destroy
    head 204
  end

  private

    def question_params
      params.require(:question).permit(:title, :body)
    end
end
