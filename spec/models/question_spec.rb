require 'spec_helper'

describe Question do
  before { @question = FactoryGirl.build(:question) }

  subject { @question }

  it { should respond_to(:title) }
  it { should respond_to(:body) }
  it { should respond_to(:user_id) }

  describe "when title is not present" do
  	before { @question.title = " "}
  	it { should_not be_valid}
  end

  describe "when body is not present" do
  	before { @question.body = " "}
  	it { should_not be_valid}
  end

  describe "when user_id is not present" do
  	before { @question.user_id = nil }
  	it { should_not be_valid}
  end

  describe "when body is too long" do
    before { @question.body = "some question" * 3000 }
    it { should_not be_valid }
  end

end
