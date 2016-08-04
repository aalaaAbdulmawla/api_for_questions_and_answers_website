class FavoriteQuestion < ActiveRecord::Base
	##Associations
  belongs_to :question
  belongs_to :user

  ##Validations
  validates :user_id, :question_id, presence: true
end
