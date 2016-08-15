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

  def no_answers
    respond_with(Question.no_answers)
  end

  def no_answers_votes
    respond_with(Question.no_answers_votes)
  end

  def newest_no_answers
    respond_with(Question.newest_no_answers)
  end
  
  def votes
    question = Question.find(params[:id])
    respond_with(question.votes.page(params[:page]).per(6))
  end

  def newest_questions
    respond_with(Question.all.order(created_at: :desc).page(params[:page]).per(6))
  end

  def under_tag
    tag = params[:name]
    respond_with(Question.under_tag(tag))
  end

  def unanswered
    respond_with(Question.unanswered)
  end

  def newest_unanswered
    respond_with(Question.newest_unanswered)
  end

  def unanswered_votes
    respond_with(Question.unanswered_votes)
  end

  def active
    respond_with(Question.active)
  end  

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end
end




