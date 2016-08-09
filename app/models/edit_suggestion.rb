class EditSuggestion < ActiveRecord::Base
	##Associations
	belongs_to :user
	belongs_to :question

  ##Validations
	validates :body, :title, :user_id, presence: true
	validates :body, length: { maximum: 2000 }

	##class methods
	def self.current_user_edit_suggestions(current_user)
		query = sanitize_sql(["SELECT * FROM edit_suggestions WHERE accepted_flag != ? AND
													 question_id IN( SELECT id FROM questions WHERE user_id = ?)", 
													 true, current_user.id ])
    connection.execute(query)
	end
end
