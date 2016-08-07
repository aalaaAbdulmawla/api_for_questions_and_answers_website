require 'rails_helper'

RSpec.describe FavoriteQuestion, type: :model do
	before { @favorite_question = FactoryGirl.build(:favorite_question)}
	subject {@favorite_question}

	it { should belong_to(:question) }
	it { should belong_to(:user)}

	describe "when user_id is not present" do
		before { @favorite_question.user_id = nil }
		it { should_not be_valid }
	end

	describe "when question_id is not present" do
		before { @favorite_question.question_id = nil }
			it { should_not be_valid }
	end
end
