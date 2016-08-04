class CreateFavoriteQuestions < ActiveRecord::Migration
  def change
    create_table :favorite_questions do |t|
      t.integer :question_id
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :favorite_questions, [:question_id, :user_id]
  end
end
