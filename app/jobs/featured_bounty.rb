class FeaturedBounty
	@queue = :award_bounty

	def self.perform(user_id, question_id)
		puts "amira"*200
		
		record = FeaturedQuestion.where(user_id: user_id, question_id: question_id).first
		question = Question.find(question_id)
		accepted_answer = question.answers.where(accepted_flag: true).first
		if ! accepted_answer.nil?
			user = User.find(accepted_answer.user_id)
			user.update(experience: user.experience + record.bounty)
		elsif question.answers.size > 0
			max = -1000000
			answer = question.answers.first
			answers = question.answers.order(:created_at).each do |ans| 
				cur = ans.votes.where(up_flag: true).size - ans.votes.where(up_flag: false).size
				if cur > max
					max = cur
					answer = ans
				end
			end
			user = User.find(answer.user_id)
			user.update(experience: user.experience + record.bounty)
		end
	end

end