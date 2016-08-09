class AddDefaultValueToAcceptedFlagColumnInAnswersTable < ActiveRecord::Migration
  def change
  	change_column :answers, :accepted_flag, :boolean, :default => false
  end
end
