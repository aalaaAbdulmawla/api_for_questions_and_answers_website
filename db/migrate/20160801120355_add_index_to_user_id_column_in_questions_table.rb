class AddIndexToUserIdColumnInQuestionsTable < ActiveRecord::Migration
  def change
  	 add_index :questions, :user_id,   unique: true
  end
end
