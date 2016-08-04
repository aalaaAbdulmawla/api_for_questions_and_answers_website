class CreateQuestionsUsers < ActiveRecord::Migration
  def change
    create_table :questions_users do |t|
    	t.integer "user_id"
    	t.integer "question_id"
    end
    add_index :questions_users, ["user_id", "question_id"]
  end
end