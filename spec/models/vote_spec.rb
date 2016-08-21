require 'spec_helper'

describe Vote do
  before { @vote = FactoryGirl.build(:vote) }
  subject { @vote}

  it { should respond_to(:up_flag) }
  it { should belong_to(:user) }
  it { should respond_to(:votable_type) }
  it { should respond_to(:votable_id) }

  describe "when user_id body is not present" do
  	before { @vote.user_id = nil }
  	it { should_not be_valid}
  end

  describe "when votable_type is not present" do
  	before { @vote.votable_type = " " }
  	it { should_not be_valid}
  end

  describe "when votable_id is not present" do
  	before { @vote.votable_id = nil }
  	it { should_not be_valid}
  end

  describe "votable type" do
    context "when votable_type is not Question, Answer or Comment" do
      before { @vote.votable_type = "Any type of model" }
      it { should_not be_valid}
    end

    context "when votable_type is Question, Answer or Comment" do
      before { @vote.votable_type = "Question" }
      it { should be_valid}
    end
  end

  describe "count votes" do
    before { @comment = FactoryGirl.create :comment }
    subject { @comment }

    it 'should have negative votes count' do
      10.times {FactoryGirl.create :vote, votable_id: @comment.id, votable_type: "Comment", user_id: 1}
      expect(Vote.count_votes("Comment", @comment)).to eq(-10)
    end

    it 'should have positive votes count' do
      5.times {FactoryGirl.create :vote, votable_id: @comment.id, votable_type: "Comment", user_id: 1, up_flag: true}
      expect(Vote.count_votes("Comment", @comment)).to eq(5)
    end

  end

end
