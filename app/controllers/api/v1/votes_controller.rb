class Api::V1::VotesController < ApplicationController
	before_action :authenticate_with_token!, only: [:vote_up, :vote_down]
	before_filter -> { check_if_already_voted true }, only: [:vote_up]
	before_filter -> { check_if_already_voted false }, only: [:vote_down]

	respond_to :json


	def vote_up
		object = parent.votes.build({user_id: current_user.id, up_flag: true})
		view_vote(object)
	end

	def vote_down
		object = parent.votes.build({user_id: current_user.id, up_flag: false})
		view_vote(object)
	end

	def view_vote(object)
		if object.save
      render json: object, status: 201, location: [:api, object]
	  else
	    render json: { errors: object.errors }, status: 422
	  end
	end

	def remove_vote
		vote = parent.votes.find_by_user_id(current_user.id)
		if ! vote.nil?
			vote.destroy
			head 404
		else
			render json: { body: "You didn't vote for this before." }, status: 422
		end
	end

	def show
		respond_with Vote.find(params[:id])
	end




	private
	def parent
    if params[:question_id]
    	Question.find params[:id] 
    elsif params[:answer_id]
    	Answer.find params[:id] 
    elsif params[:comment_id]
    	Answer.find params[:id] 
    end
  end

  def check_if_already_voted(up_flag)
  	if parent.votes.where(user_id: current_user.id).count != 0 
  		vote = parent.votes.where(user_id: current_user.id).first
  		if up_flag == vote.up_flag
  			render json: { body:  "You already voted #{up_flag == true ? "up" : "down"} for this." }, 
  						status: 422
  		end
  	end
  end


end















