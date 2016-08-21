class Question < ActiveRecord::Base
	##Associations
	belongs_to :user
	has_many :answers, dependent: :destroy
	has_and_belongs_to_many :tags
	has_many :favorite_questions, dependent: :destroy
  has_many :favorited_by, through: :favorite_questions, source: :user

  has_many :featured_questions, dependent: :destroy
  has_many :featured_by, through: :featured_questions, source: :user

  has_many :comments, as: :commentable, dependent: :destroy
	has_many :votes, as: :votable, dependent: :destroy
	has_many :edit_suggestions, dependent: :destroy

	##Validations
	validates :body, :title, :user_id, presence: true
	validates :body, length: { maximum: 2000 }

	##Scopes
	def self.no_answers
	 select { |question| question.answers.size == 0 }
	end

	#To be done
	def self.no_answers_votes
		Question.no_answers.flat_map {|q| q.votes}
	end

	def self.newest_no_answers
		Question.no_answers.sort_by(&:created_at).reverse
	end

	def self.under_tag(tag)
		select { |question| question.tags.where(name: tag).count > 0 }
	end

	def self.unanswered
		select { |question| question.answers.where(accepted_flag: true).size == 0 }
	end	

	def self.newest_unanswered
		Question.unanswered.sort_by(&:created_at).reverse
	end

	def self.unanswered_votes
		Question.unanswered.flat_map {|q| q.votes}
	end

	def self.active
		ans = []
		Question.where('created_at >= :five_days_ago', :five_days_ago  => Time.now - 10.days).each do |question|
			if question.answers.where(accepted_flag: true).count == 0
				ans << question
			end
		end
		return ans
	end

end