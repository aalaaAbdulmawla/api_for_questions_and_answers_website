class Api::V1::EditSuggestionsController < ApplicationController
	before_action :authenticate_with_token!, only: [:create, :index, :approve_edit]
	respond_to :json

	def create
		question = Question.find(params[:question_id])
		edit_suggestion = current_user.edit_suggestions.build(edit_suggestion_params)
		if edit_suggestion.save
			render json: edit_suggestion, status: 201, location: [:api, edit_suggestion]
	  else
	    render json: { errors: edit_suggestion.errors }, status: 422
	  end
	end

	def index
		respond_with EditSuggestion.current_user_edit_suggestions(current_user)
	end

	def approve_edit
		edit = EditSuggestion.find(params[:id])
		question = Question.find(edit.question_id)
		if question.update(title: edit.title, body: edit.body)
			edit.update(accepted_flag: true)
			render json: question, status: 200, location: [:api, question]
    else
      render json: { errors: question.errors }, status: 422
    end
	end


	def show
		respond_with EditSuggestion.find(params[:id])
	end

	private

	def edit_suggestion_params
		params.require(:edit_suggestion).permit(:title, :body).merge(user_id: current_user.id, 
																													question_id: params[:question_id])
	end
end