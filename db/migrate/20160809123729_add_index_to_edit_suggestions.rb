class AddIndexToEditSuggestions < ActiveRecord::Migration
  def change
  	add_index :edit_suggestions, [:user_id, :question_id]
  end
end
