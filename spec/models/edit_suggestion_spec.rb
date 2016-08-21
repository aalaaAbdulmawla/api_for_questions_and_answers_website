require 'rails_helper'

describe EditSuggestion  do
  before { 
  	@user = FactoryGirl.create :user
  	@question = FactoryGirl.create :question, user_id: 1
  	@edit_suggestion = FactoryGirl.create(:edit_suggestion, user_id: @user.id, question_id: @question.id)
  }
	subject {@edit_suggestion}

	it { should belong_to(:question) }
	it { should belong_to(:user)}

  it 'should list edit suggestions for the given user' do
    expect(EditSuggestion.current_user_edit_suggestions(@user).size).to eq(1)
  end


end
