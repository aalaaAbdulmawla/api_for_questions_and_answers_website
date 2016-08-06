class AddIndexToAuthTokenColumn < ActiveRecord::Migration
  def change
  	add_index :users, :auth_token, name: "index_users_on_auth_token", unique: true
  end
end
