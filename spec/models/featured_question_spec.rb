require 'rails_helper'

RSpec.describe FeaturedQuestion, type: :model do
  before { @featured_question = FactoryGirl.build(:featured_question) }

  subject { @featured_question }

  it { should belong_to(:user) }
  it { should belong_to(:question) }

  describe "when bounty is not present" do
  	before { @featured_question.bounty = nil}
  	it { should_not be_valid}
  end

end
