require 'spec_helper'

describe Answer do
  before { @answer = FactoryGirl.build(:answer) }
  subject { @answer }

  it { should respond_to(:body) }
  it { should respond_to(:user_id) }
  it { should respond_to(:question_id) }
  it { should respond_to(:accepted_flag) }
end
