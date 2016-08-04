require 'spec_helper'

describe Tag do
  before { @tag = FactoryGirl.build(:tag) }

  subject { @tag }

  it { should respond_to(:name) }

  describe "when name is not present" do
  	before { @tag.name = " "}
  	it { should_not be_valid}
  end

  describe "when name is dublicated" do
  	before { 
  		@tag.save!
  		@second_tag = FactoryGirl.build(:tag)
  	}
  	subject { @second_tag }
  	it { should_not be_valid }
  end

end
