require 'spec_helper'

describe Answer do
  before { @answer = FactoryGirl.build(:answer) }
  subject { @answer }

  it { should respond_to(:body) }
  it { should respond_to(:accepted_flag) }
  it { should belong_to(:user)}
  it { should belong_to(:question)}
  it { should have_many(:comments) }
  it { should have_many(:votes) }

  describe "when answer's body is not present" do
  	before { @answer.body = " "}
  	it { should_not be_valid}
  end

  describe "when body is too large" do
    before { @answer.body  = "some answer" * 3000 }
    it { should_not be_valid }
  end


end
