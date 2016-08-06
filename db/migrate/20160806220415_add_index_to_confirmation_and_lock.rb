class AddIndexToConfirmationAndLock < ActiveRecord::Migration
  def change
  	add_index :users, :confirmation_token, name: "index_users_on_confirmation_token", unique: true
  	add_index :users, :unlock_token, name: "index_users_on_unlock_token", unique: true
  end
end
