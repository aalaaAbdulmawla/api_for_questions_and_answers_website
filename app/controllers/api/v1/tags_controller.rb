class Api::V1::TagsController < ApplicationController
	before_action :authenticate_with_token!, only: [:create]
	before_filter :check_if_tag_already_exists, only: [:vote_up]
	respond_to :json

	def create
		question = Question.find(params[:question_id])
		if Tag.where(name: params[name]).count == 0
			@tag = question.tags.build(tag_params) 
		else 
			question.tags
		if tag
	end


	private
	def tag_params
    params.require(:tag).permit(:name)
  end
end
