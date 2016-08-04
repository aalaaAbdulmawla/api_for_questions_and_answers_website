require 'spec_helper'

describe Question do
  before { @question = FactoryGirl.build(:question) }

  subject { @question }

  it { should respond_to(:title) }
  it { should respond_to(:body) }
  it { should respond_to(:user_id) }

end
