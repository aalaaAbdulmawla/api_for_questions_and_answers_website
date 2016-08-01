class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :votable_id
      t.integer :votable_type
      t.boolean :up_flag

      t.timestamps null: false
    end

    add_index :votes, :user_id
    add_index :votes, :votable_id
  end
end
