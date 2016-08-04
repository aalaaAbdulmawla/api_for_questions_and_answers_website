require 'spec_helper'

describe Vote do
  before { @vote = FactoryGirl.build(:vote) }
  subject { @vote}

  it { should respond_to(:up_flag) }
  it { should respond_to(:user_id) }
  it { should respond_to(:votable_type) }
  it { should respond_to(:votable_id) }
end
