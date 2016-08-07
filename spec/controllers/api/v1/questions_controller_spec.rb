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






























end










































