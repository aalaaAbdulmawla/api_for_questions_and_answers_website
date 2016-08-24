require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
	before(:each) do
		request.headers['Accept'] = "application/vnd.api_stackOverFlow.v1, #{Mime::JSON}"
		request.headers['Content-Type'] = Mime::JSON.to_s
	end

	describe "GET #show" do
		before(:each) do
			@user = FactoryGirl.create :user
			get :show, id: @user.id, format: :json
		end

		it "returns te information about a reporter on a hash" do
			user_response = json_response
      expect(user_response[:email]).to eql @user.email
		end

		it { should respond_with 200 }
	end

	describe "POST #create" do

    context "when is successfully created" do
      before(:each) do
        @user_attributes = FactoryGirl.attributes_for :user
        post :create, { user: @user_attributes }, format: :json
      end

      it "renders the json representation for the user record just created" do
        user_response = json_response
        expect(user_response[:email]).to eql @user_attributes[:email]
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        #notice I'm not including the email
        @invalid_user_attributes = { password: "12345678",
                                     password_confirmation: "12345678" }
        post :create, { user: @invalid_user_attributes }, format: :json
      end

      it "renders an errors json" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end

      it "renders the json errors on why the user could not be created" do
        user_response = json_response
        expect(user_response[:errors][:email]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end

  describe "PUT/PATCH #update" do
    before(:each) do
      @user = FactoryGirl.create :user
      request.headers['Authorization'] =  @user.auth_token
    end
    context "when is successfully updated" do
      before(:each) do
        patch :update, { id: @user.id,
                         user: { email: "newmail@example.com" } }, format: :json
      end

      it "renders the json representation for the updated user" do
        user_response = json_response
        expect(user_response[:email]).to eql "newmail@example.com"
      end

      it { should respond_with 200 }
    end

    context "when is not created" do
      before(:each) do
        patch :update, { id: @user.id,
                         user: { email: "bademail.com" } }, format: :json
      end

      it "renders an errors json" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be created" do
        user_response = json_response
        expect(user_response[:errors][:email]).to include "is invalid"
      end

      it { should respond_with 422 }
    end
  end

  describe "DELETE #destroy" do
	  before(:each) do
	    @user = FactoryGirl.create :user
      api_authorization_header @user.auth_token
	    delete :destroy, { id: @user.id }, format: :json
	  end

	  it { should respond_with 204 }
	end

  describe "GET #questions" do
    before(:each) do
      @user = FactoryGirl.create :user
      @questions = 5.times { FactoryGirl.create :question, user_id: @user.id }
      get :questions, id: @user.id, format: :json
    end

    it "returns 5 records from the database" do
      questions_response = json_response
      expect(questions_response.size).to eql 5
    end

    it { should respond_with 200 }
  end

  describe "GET #answers" do
    before(:each) do
      @user = FactoryGirl.create :user
      @question = FactoryGirl.create :question, user_id: @user.id
      @questions = 5.times { FactoryGirl.create :answer, question_id: @question.id, user_id: @user.id }
      get :answers, id: @user.id, format: :json
    end

    it "returns 5 records from the database" do
      questions_response = json_response
      expect(questions_response.size).to eql 5
    end

    it { should respond_with 200 }
  end

  describe "GET #comments" do
    before(:each) do
      @user = FactoryGirl.create :user
      @question = FactoryGirl.create :question, user_id: @user.id
      @questions = 5.times { FactoryGirl.create :comment, commentable_id: @question.id, 
        user_id: @user.id, commentable_type: "Question" }
      get :comments, id: @user.id, format: :json
    end

    it "returns 5 records from the database" do
      questions_response = json_response
      expect(questions_response.size).to eql 5
    end

    it { should respond_with 200 }
  end

  describe "GET #favorites" do
    before(:each) do
      @user = FactoryGirl.create :user
      @question = FactoryGirl.create :question, user_id: @user.id
      @favorite_question = FactoryGirl.create :favorite_question, user_id: @user.id, 
      question_id: @question.id
      get :favorites, id: @user.id, format: :json
    end

    it "returns 1 records from the database" do
      questions_response = json_response
      expect(questions_response.size).to eql 1
    end

    it { should respond_with 200 }
  end

end
































