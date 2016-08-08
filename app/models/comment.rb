class Comment < ActiveRecord::Base
	##Associations
	belongs_to :user
	belongs_to :commentable, polymorphic: true
	has_many :votes, as: :votable

	##Validations
	#validates :body, :user_id, :commentable_type, :commentable_id, presence: :true
	validates :body, presence: :true
	validates :commentable_type, inclusion: { in: %w(Question Answer),
    message: "%{value} is not a valid type" }
  validates :body, length: {maximum: 200}
end
