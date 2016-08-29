class Api::V1::QuestionsController < ApplicationController
	before_action :authenticate_with_token!, only: [:create, :update, :favorite, :unfavorite]
  
  caches_page :index, :show
  cache_sweeper :question_sweeper
	respond_to :json

  api! "Lists all questions."
	def index
		respond_with Question.all.page(params[:page]).per(6)
	end

  api! "Shows the given question."
	def show
		respond_with Question.find(params[:id])
	end

  api! "Creates a new question [auth required]"
	def create
    question = current_user.questions.build(question_params)
    if question.save
      render json: question, status: 201, location: [:api, question]
    else
      render json: { errors: question.errors }, status: 422
    end
  end

  api! "Updates the given question [auth required]."
  def update
    question = current_user.questions.find(params[:id])
    if question.update(question_params)

      render json: question, status: 200, location: [:api, question]
    else
      render json: { errors: question.errors }, status: 422
    end
  end

  api! "Delets the given question [auth required]."
  def destroy
    question = current_user.questions.find(params[:id])
    question.destroy
    head 204
  end

  api! "Marks the given question as favorite question [auth required]."
  def favorite
  	question = Question.find(params[:id])
  	if !current_user.favorites.include?question
  		current_user.favorites << question
      render json: question, status: 200, location: [:api, question]
    else
      render json: { errors: "The question is already in your favorites list"}, status: 422
    end
  end

  api! "Removes the given question from the favorite questions list [auth required]."
  def unfavorite
  	question = current_user.favorites.find(params[:id])
  	current_user.favorites.delete(question)
    head 204
  end

  api! "Shows a list of questions with on answers."
  def no_answers
    respond_with(Question.no_answers)
  end

  # api! "Shows votes of questions with on answers"
  # def no_answers_votes
  #   respond_with(Question.no_answers_votes)
  # end

  api! "Shows a list of newest questions with no answers"
  def newest_no_answers
    respond_with(Question.newest_no_answers)
  end
  
  api! "Shows count of votes for a given question."
  def votes
    question = Question.find(params[:id])
    respond_with(Vote.count_votes("Question", question))
  end

  api! "Shows a list of newest questions."
  def newest_questions
    respond_with(Question.all.order(created_at: :desc).page(params[:page]).per(6))
  end

  api! "Shows a list of questions under a certain tag."
  def under_tag
    tag = params[:name]
    respond_with(Question.under_tag(tag))
  end

  api! "Shows a list of unanswered questions."
  def unanswered
    respond_with(Question.unanswered)
  end

  api! "Shows a list of newest unanswered questions."
  def newest_unanswered
    respond_with(Question.newest_unanswered)
  end

  api! "Shows a list of votes of unanswered questions."
  def unanswered_votes
    respond_with(Question.unanswered_votes)
  end

  api! "Shows a list of active questions."
  def active
    respond_with(Question.active)
  end  

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end
end




