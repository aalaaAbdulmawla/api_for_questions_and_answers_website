class Api::V1::TagsController < ApplicationController
	before_action :authenticate_with_token!, only: [:create]
	before_filter :set_tag, only: [:create]
	respond_to :json

	def create
		question = Question.find(params[:question_id])
		question.tags << @tag
		render json: { body: {question_id: params[:question_id], tags: question.tags} }, status: 200
	end

	def question_tags
	  question = Question.find(params[:id])
		render json: { body: {question_id: params[:id], tags: question.tags} }, status: 200
	end

	def index
		respond_with Tag.all
	end

	def destroy
		question = Question.find(params[:question_id])
		tag = question.tags.find params[:id]
		question.tags.destroy(tag)
		head 404
	end


	private
	def tag_params
    params.require(:tag).permit(:name)
  end

  def set_tag
  	@tag = Tag.where(name: params[:name]).first
  	if @tag.nil?
  		@tag = Tag.new(tag_params) 
  	end
    render json: { errors: @tag.errors }, status: 422 unless @tag.save
  end
end
