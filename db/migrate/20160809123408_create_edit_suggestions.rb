class CreateEditSuggestions < ActiveRecord::Migration
  def change
    create_table :edit_suggestions do |t|
    	t.integer :user_id
    	t.integer :question_id
    	t.string  :title
    	t.text    :body
    	t.boolean :accepted_flag, default: false

      t.timestamps null: false
    end
  end
end
