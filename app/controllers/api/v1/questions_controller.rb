class Api::V1::QuestionsController < ApplicationController
	before_action :authenticate_with_token!, only: [:create, :update, :favorite, :unfavorite]
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

  def favorite
  	question = Question.find(params[:id])
  	if !current_user.favorites.include?question
  		current_user.favorites << question
      render json: question, status: 200, location: [:api, question]
    else
      render json: { errors: "The question is already in your favorites list"}, status: 422
    end
  end

  def unfavorite
  	question = current_user.favorites.find(params[:id])
  	current_user.favorites.delete(question)
    head 204
  end
  

  private

    def question_params
      params.require(:question).permit(:title, :body)
    end
end




