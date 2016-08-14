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

	def self.no_answers
		result = []
		Question.all.each do |question|
			if question.answers.count > 0
				result << question
			end
		end
		return result
	end

	def self.no_answers_votes
		result = []
		Question.no_answers.each do |question|
			result << question.votes
		end
		return result
	end

	def self.newest_no_answers
		Question.no_answers.sort_by(&:created_at).reverse
	end

end
