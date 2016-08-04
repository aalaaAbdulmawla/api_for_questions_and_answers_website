class Vote < ActiveRecord::Base
	##Associations
	belongs_to :user
	belongs_to :votable, polymorphic: true

	##validations
	validates :user_id, :votable_type, :votable_id, presence: true
	validates :votable_type, inclusion: { in: %w(Question Answer Comment),
    message: "%{value} is not a valid type" }
end
