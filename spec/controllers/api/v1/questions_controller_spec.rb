require 'rails_helper'

RSpec.describe Api::V1::QuestionsController, type: :controller do
	describe "GET #index" do
		before(:each) do
			4.times { FactoryGirl.create :question }
			get :index, format: :json
		end

		it "returns 4 records from the database" do
			questions_response = json_response
      expect(questions_response.size).to eql 4
 		end

		it { should respond_with 200 }
	end

	describe "GET #show" do
		before(:each) do
			@question = FactoryGirl.create :question
			get :show, id: @question.id, format: :json
		end

		it "returns the information about a reporter on a hash" do
			questions_response = json_response
			expect(questions_response[:title]).to eql @question.title
		end

		it { should respond_with 200 }
	end


	describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        user = FactoryGirl.create :user
        @question_attributes = FactoryGirl.attributes_for :question
        api_authorization_header user.auth_token
        post :create, { user_id: user.id, question: @question_attributes }
      end

      it "renders the json representation for the question record just created" do
        question_response = json_response
        expect(question_response[:title]).to eql @question_attributes[:title]
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        user = FactoryGirl.create :user
        @invalid_question_attributes = { title: "", body: nil }
        api_authorization_header user.auth_token
        post :create, { user_id: user.id, question: @invalid_question_attributes }
      end

      it "renders an errors json" do
        question_response = json_response
        expect(question_response).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be created" do
        question_response = json_response
        expect(question_response[:errors][:title]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end

  describe "PUT/PATCH #update" do
    before(:each) do
      @user = FactoryGirl.create :user
      @question = FactoryGirl.create :question, user: @user
      api_authorization_header @user.auth_token
    end

    context "when is successfully updated" do
      before(:each) do
        patch :update, { user_id: @user.id, id: @question.id,
              question: { title: "Any title" } }
      end

      it "renders the json representation for the updated user" do
        question_response = json_response
        expect(question_response[:title]).to eql "Any title"
      end

      it { should respond_with 200 }
    end

    context "when is not updated" do
      before(:each) do
        patch :update, { user_id: @user.id, id: @question.id,
              question: { body: "" } }
      end

      it "renders an errors json" do
        question_response = json_response
        expect(question_response).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be created" do
        question_response = json_response
        expect(question_response[:errors][:body]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create :user
      @question = FactoryGirl.create :question, user: @user
      api_authorization_header @user.auth_token
      delete :destroy, { user_id: @user.id, id: @question.id }
    end

    it { should respond_with 204 }
  end
end



























end










































