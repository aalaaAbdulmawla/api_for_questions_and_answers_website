class Api::V1::CommentsController < ApplicationController
	before_action :authenticate_with_token!, only: [:create]
	respond_to :json

	def create
    comment = parent.comments.build(comment_params)
		if comment.save
      render json: comment, status: 201, location: [:api, comment]
	  else
	    render json: { errors: comment.errors }, status: 422
	  end
	end

	def show
		respond_with Comment.find(params[:id])
	end

  private

  def parent
    if params[:question_id]
    	Question.find params[:question_id] 
    elsif params[:answer_id]
    	Answer.find params[:answer_id] 
    end
  end

  def comment_params
    params.require(:comment).permit(:body).merge(user_id: current_user.id)
  end

end
