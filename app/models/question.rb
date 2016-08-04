class Question < ActiveRecord::Base
	##Associations
	belongs_to :user
	has_many :answers, dependent: :destroy
	has_and_belongs_to_many :tags
	has_many :favorite_questions
  has_many :favorited_by, through: :favorite_questions, source: :user
  has_many :comments, as: :commentable
	has_many :votes, as: :votable

	##Validations
	validates :body, :title, :user_id, presence: true
	validates :body, length: { maximum: 2000 }

end
