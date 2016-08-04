require 'rails_helper'

RSpec.describe FavoriteQuestion, type: :model do
	before { @favorite_question = FactoryGirl.build(:favorite_question)}
	subject {@favorite_question}

	it { should respond_to(:question_id) }
	it { should respond_to(:user_id)}
end
