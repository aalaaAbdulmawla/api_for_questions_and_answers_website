require 'spec_helper'

describe Tag do
  before { @tag = FactoryGirl.build(:tag) }

  subject { @tag }

  it { should respond_to(:name) }

end
