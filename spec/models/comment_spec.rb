require 'spec_helper'

describe Comment do
  before { @comment = FactoryGirl.build(:comment) }
  subject { @comment}

  it { should respond_to(:body) }
  it { should respond_to(:user_id) }
  it { should respond_to(:commentable_type) }
  it { should respond_to(:commentable_id) }
 
end
