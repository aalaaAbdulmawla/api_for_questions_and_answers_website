class AddIndexOnCommentsAndVotes < ActiveRecord::Migration
  def change
  	remove_index :comments, :commentable_id
  	remove_index :comments, :user_id
  	add_index :comments, [:user_id, :commentable_type, :commentable_id], :name => 'my_index'

  	remove_index :votes, :votable_id
  	remove_index :votes, :user_id
  	add_index :votes, [:user_id, :votable_type, :votable_id], :name => 'my_votes_index'

  end
end
