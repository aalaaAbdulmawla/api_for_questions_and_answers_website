require 'spec_helper'

describe User do
  before { @user = FactoryGirl.build(:user) }
  subject { @user }

  ##Test columns
  it { should respond_to(:auth_token) }
  it { should validate_uniqueness_of(:auth_token)}
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:birth_date) }
  it { should respond_to(:location) }
  it { should respond_to(:job) }
  it { should respond_to(:about) }
  it { should respond_to(:experience) }

  ##Test associations
  it { should have_many(:questions) }
  it { should have_many(:answers) }
  it { should have_many(:comments) }
  it { should have_many(:votes) }
  it { should have_many(:favorites) }

  describe "#questions association" do
    before do
      @user.save
      3.times { FactoryGirl.create :question, user: @user }
    end

    it "destroys the associated questions on self destruct" do
      questions = @user.questions
      @user.destroy
      questions.each do |question|
        expect(Question.find(question)).to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "#answers association" do

    before do
      @user.save
      3.times { FactoryGirl.create :answer, user: @user }
    end

    it "destroys the associated answers on self destruct" do
      answers = @user.answers
      @user.destroy
      answers.each do |answer|
        expect(Answer.find(answer)).to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "#comments association" do
    before do
      @user.save
      3.times { FactoryGirl.create :comment, user: @user, commentable_type: Question }
    end

    it "destroys the associated comments on self destruct" do
      comments = @user.comments
      @user.destroy
      comments.each do |comment|
        expect(Comment.find(comment)).to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "#votes association" do

    before do
      @user.save
      3.times { FactoryGirl.create :vote, user: @user, votable_type: Question  }
    end

    it "destroys the associated votes on self destruct" do
      votes = @user.votes
      @user.destroy
      votes.each do |vote|
        expect(Vote.find(vote)).to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "#favorite questions association" do

    before do
      @user.save
      3.times { FactoryGirl.create :favorite_question, user: @user }
    end

    it "destroys the associated favorite questions on self destruct" do
      favorite_questions = @user.favorites
      @user.destroy
      favorite_questions.each do |favorite|
        expect(FavoriteQuestion.find(favorite)).to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  ##Test class methods
  describe "#generate_authentication_token!" do
    it "generates a unique token" do
      #Devise.stub(:friendly_token).and_return("auniquetoken123")
      allow(Devise).to receive_messages(:friendly_token => "auniquetoken123")
      @user.generate_authentication_token!
      expect(@user.auth_token).to eql "auniquetoken123"
    end

    it "generates another token when one already has been taken" do
      existing_user = FactoryGirl.create(:user, auth_token: "auniquetoken123")
      @user.generate_authentication_token!
      expect(@user.auth_token).not_to eql existing_user.auth_token
    end

  end

  describe "when first_name is too long" do
    before { @user.first_name = "some name" * 200 }
    it { should_not be_valid }
  end

  describe "when about is too long" do
    before { @user.about = "about" * 2000 }
    it { should_not be_valid }
  end

  describe "birth_date is invalid" do
    # context "when birth_date is invalid string" do
    #   before { @user.birth_date = "a bad string"}
    #   it { should_not be_valid }
    # end

    # context "when birth_date is wrong formated date" do
    #   before { @user.birth_date = "02-31-2016"}
    #   expect(@user.valid?).to eql false
    # end

    # context "when birth_date is less than ten" do
    #   before { @user.birth_date = Date.today }
    #   expect(@user.valid?).to eql false
    # end
  end

  describe "when birth_date is valid" do
    before { @user.birth_date = "2000/08/01"}
    it { should be_valid }
  end


end
