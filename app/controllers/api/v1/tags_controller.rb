class Api::V1::TagsController < ApplicationController
	before_action :authenticate_with_token!, only: [:create, :destroy]
	before_filter :set_tag, only: [:create]
	respond_to :json

	api! "Adds a tag to the question [auth required]"
	def create
		question = Question.find(params[:question_id])
		question.tags << @tag
		render json: { body: {question_id: params[:question_id], tags: question.tags} }, status: 200
	end

	api! "Lists the tags of the given question."
	def question_tags
	  question = Question.find(params[:id])
		render json: { body: {question_id: params[:id], tags: question.tags} }, status: 200
	end

	api! "Shows a list of all tags."
	def index
		respond_with Tag.all
	end

	api! "Searches for tags with the given name."
	def search
		name = params[:name]
		respond_with Tag.search(name)
	end

	api! "Shows a list of the popular tags."
	def popular
		respond_with Tag.popular
	end

	api! "Removes the given tag from the given question [auth required]"
	def destroy
		question = Question.find(params[:question_id])
		tag = question.tags.find params[:id]
		question.tags.destroy(tag)
		head 404
	end

	api! "Shows a list of the newest tags."
	def newest
		respond_with Tag.newest
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
