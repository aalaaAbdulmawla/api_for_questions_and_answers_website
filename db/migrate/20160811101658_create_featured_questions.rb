class CreateFeaturedQuestions < ActiveRecord::Migration
  def change
    create_table :featured_questions do |t|

      t.timestamps null: false
    end
  end
end
