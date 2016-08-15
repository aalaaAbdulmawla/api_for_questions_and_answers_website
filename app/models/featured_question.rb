class FeaturedQuestion < ActiveRecord::Base
  ##Associations
  belongs_to :question
  belongs_to :user

  ##Validations
  validates :user_id, :question_id, :bounty, presence: true
  validates :duration, :numericality => { :greater_than => 0, :less_than_or_equal_to => 7 }
end
