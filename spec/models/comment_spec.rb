require 'spec_helper'

describe Comment do
  before { @comment = FactoryGirl.build(:comment) }
  subject { @comment}

  ##Testing columns exists
  it { should respond_to(:body) }
  it { should belong_to(:user) }
  it { should respond_to(:commentable_type) }
  it { should respond_to(:commentable_id) }

  ##Testing validations
  describe "when body is not present" do
  	before { @comment.body = " "}
  	it { should_not be_valid}
  end

  describe "when user_id body is not present" do
  	before { @comment.user_id = nil }
  	it { should_not be_valid}
  end

  describe "when commentable_type is not present" do
  	before { @comment.commentable_type = nil }
  	it { should_not be_valid}
  end

  describe "when commentable_id is not present" do
  	before { @comment.commentable_id = nil }
  	it { should_not be_valid}
  end

  describe "commentable_type" do
    context "when commentable_type is not Question or Answer" do
      before { @comment.commentable_type = "Any type of model" }
      it { should_not be_valid}
    end

    context "when commentable_type is Question or Answer" do
      before { @comment.commentable_type = "Question" }
      it { should be_valid}
    end
  end

  describe "when comment size is too large" do
    before { @comment.body = "some comment" * 1000 }
    it { should_not be_valid}
  end
 
end
