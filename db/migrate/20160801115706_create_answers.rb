class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :body
      t.integer :user_id
      t.integer :question_id
      t.boolean :accepted_flag

      t.timestamps null: false
    end
    add_index :answers, :user_id,            unique: true
    add_index :answers, :question_id,        unique: true
  end
end
