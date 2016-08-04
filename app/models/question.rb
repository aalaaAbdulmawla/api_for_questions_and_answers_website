class Question < ActiveRecord::Base
	belongs_to :user
	has_many :answers, dependent: :destroy
	has_and_belongs_to_many :tags

	has_many :favorite_questions # just the 'relationships'
  has_many :favorited_by, through: :favorite_questions, source: :user

  has_many :comments, as: :commentable
	has_many :votes, as: :votable
end
