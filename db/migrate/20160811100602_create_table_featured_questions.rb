class CreateTableFeaturedQuestions < ActiveRecord::Migration
  def change
    create_table :featured_questions, id: false do |t|
    	t.integer :user_id
    	t.integer :question_id
    	t.integer :bounty
    	t.integer :duration, default: 3

    	t.timestamps null: false
    end

    add_index :featured_questions, [:user_id, :question_id]
  end
end
