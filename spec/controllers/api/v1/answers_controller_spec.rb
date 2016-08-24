require 'rails_helper'

RSpec.describe Api::V1::AnswersController, type: :controller do

	describe "GET #show" do
		before(:each) do
			user = FactoryGirl.create :user
			question = FactoryGirl.create :question, user: user
			@answer = FactoryGirl.create :answer, question: question, user: user
			get :show, id: @answer.id, format: :json
		end

		it "returns the information about a reporter on a hash" do
			answers_response = json_response
			expect(answers_response[:body]).to eql @answer.body
		end

		it { should respond_with 200 }
	end


	describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        user = FactoryGirl.create :user
        question = FactoryGirl.create :question, user: user
        @answer_attributes = FactoryGirl.attributes_for :answer, question: question, user: user
        api_authorization_header user.auth_token
        post :create, { question_id: question.id, answer: @answer_attributes }
      end

      it "renders the json representation for the answer record just created" do
        answer_response = json_response
        expect(answer_response[:title]).to eql @answer_attributes[:title]
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        user = FactoryGirl.create :user
        question = FactoryGirl.create :question
        @invalid_answer_attributes = { title: "", body: nil }
        api_authorization_header user.auth_token
        post :create, { user_id: user.id, question_id: question.id, answer: @invalid_answer_attributes }
      end

      it "renders an errors json" do
        answer_response = json_response
        expect(answer_response).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be created" do
        answer_response = json_response
        expect(answer_response[:errors][:body]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end

  describe "PUT/PATCH #update" do
    before(:each) do
      @user = FactoryGirl.create :user
      @question = FactoryGirl.create :question, user: @user
      @answer = FactoryGirl.create :answer, user: @user, question: @question
      api_authorization_header @user.auth_token
    end

    context "when is successfully updated" do
      before(:each) do
        patch :update, { user_id: @user.id, id: @answer.id,
              answer: { body: "Any body....." } }
      end

      it "renders the json representation for the updated user" do
        answer_response = json_response
        expect(answer_response[:body]).to eql "Any body....."
      end

      it { should respond_with 200 }
    end

    context "when is not updated" do
      before(:each) do
        patch :update, { user_id: @user.id, id: @answer.id,
              answer: { body: "" } }
      end

      it "renders an errors json" do
        answer_response = json_response
        expect(answer_response).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be created" do
        answer_response = json_response
        expect(answer_response[:errors][:body]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end
end
