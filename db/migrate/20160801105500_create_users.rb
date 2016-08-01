class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.date :birth_date
      t.string :location
      t.string :job
      t.text :about
      t.integer :experience

      t.timestamps null: false
    end
  end
end
