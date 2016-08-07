require 'spec_helper'

describe Question do
  before { @question = FactoryGirl.build(:question) }

  subject { @question }

  it { should respond_to(:title) }
  it { should respond_to(:body) }
  it { should belong_to(:user) }
  it { should have_many(:answers) }
  it { should have_many(:comments) }
  it { should have_many(:votes) }
  it { should have_many(:favorited_by)}


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
