class ChangeDataFormatInCommentsAndVotesTables < ActiveRecord::Migration
  def change 
    change_column :comments, :commentable_type, :string
    change_column :votes, :votable_type, :string
  end
end
