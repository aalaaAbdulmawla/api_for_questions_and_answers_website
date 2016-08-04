class DropQuestionsUsersTable < ActiveRecord::Migration
  def change
  	drop_table :questions_users
  end
end
