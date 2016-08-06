class AddAuthenticationTokenToUsers < ActiveRecord::Migration
  def change
  	remove_index :users, :confirmation_token
  	remove_index :users, :unlock_token
    add_column :users, :auth_token, :string, default: ""
    # add_index :users, :auth_token, unique: true
  end
end
