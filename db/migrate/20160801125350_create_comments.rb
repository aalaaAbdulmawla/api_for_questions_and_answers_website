class CreateComments < ActiveRecord::Migration
  def change
  	drop_table :comments
    create_table :comments do |t|
      t.string :body
      t.integer :user_id
      t.integer :commentable_type
      t.integer :commentable_id

      t.timestamps null: false
    end

    add_index :comments, :user_id
    add_index :comments, :commentable_id
  end
end
