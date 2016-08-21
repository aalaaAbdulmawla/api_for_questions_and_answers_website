require 'spec_helper'

describe Question do
  before { @question = FactoryGirl.build(:question) }

  subject { @question }

  it { should respond_to(:title) }
  it { should respond_to(:body) }
  it { should belong_to(:user) }
  it { should have_many(:answers) }
  it { should have_many(:comments) }
  it { should have_many(:votes) }
  it { should have_many(:favorited_by)}


  describe "when title is not present" do
  	before { @question.title = " "}
  	it { should_not be_valid}
  end

  describe "when body is not present" do
  	before { @question.body = " "}
  	it { should_not be_valid}
  end

  describe "when user_id is not present" do
  	before { @question.user_id = nil }
  	it { should_not be_valid}
  end

  describe "when body is too long" do
    before { @question.body = "some question" * 3000 }
    it { should_not be_valid }
  end


  describe 'no answers' do
    before{ @question.save!}
    it { expect(Question.no_answers.size).to eq(1) }
  end

  describe 'unanswered' do
    before{ @question.save!}
    it { expect(Question.unanswered.size).to eq(1) }
  end

  describe 'newest no answers' do
    before{ @question.save!}
    it { expect(Question.newest_no_answers.size).to eq(1) }
  end

  describe "under tag" do
    before{@question.tags << FactoryGirl.create(:tag, name: "test tag"); @question.save }
    subject { @question }
    it { expect(Question.under_tag("test tag").first).to eql(@question) }
  end

  describe "active" do
    before{@question.save }
    subject { @question }
    it { expect(Question.active.first).to eql(@question) }
  end



end


















