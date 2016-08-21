require 'spec_helper'

describe Tag do
  before { @tag = FactoryGirl.build(:tag) }

  subject { @tag }

  it { should respond_to(:name) }

  describe "when name is not present" do
  	before { @tag.name = " "}
  	it { should_not be_valid}
  end


  describe "newest tag" do
    before { @tag.name = "newest tag"; @tag.save! }
    it { expect(Tag.newest.first).to eq(@tag) }
  end

end
