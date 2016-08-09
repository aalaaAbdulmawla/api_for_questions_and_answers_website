class AddDefaultValueToExperience < ActiveRecord::Migration
  def change
  	change_column :users, :experience, :integer, :default => 1
  end
end
