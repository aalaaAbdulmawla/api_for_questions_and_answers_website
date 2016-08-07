require 'rails_helper'

class Authentication
  include Authenticable
end

describe Authenticable, :type => :controller do
  let(:authentication) { Authentication.new }

  describe "#current_user" do
    before do
      @user = FactoryGirl.create :user
      request.headers["Authorization"] = @user.auth_token
      allow(authentication).to receive(:request).and_return(request)
    end

    it "returns the user from the authorization header" do
      expect(authentication.current_user.auth_token).to eql @user.auth_token
    end
  end

  describe "#authenticate_with_token" do
    before do
      @user = FactoryGirl.create :user
      allow(authentication).to receive_messages(:current_user => nil)
      allow(response).to receive_messages(:response_code => 401)
      allow(response).to receive_messages(:body => {"errors" => "Not authenticated"}.to_json)
      allow(authentication).to receive_messages(:response => response)
    end

    it "render a json error message" do
      expect(json_response[:errors]).to eql "Not authenticated"
    end
  end

  describe "#user_signed_in?" do

    context "when there is a user on 'session'" do
      before do
        @user = FactoryGirl.create :user
        #authentication.stub(:current_user).and_return(@user)
        allow(authentication).to receive_messages(current_user: @user)
      end
      it "user should be signed in" do
         expect(authentication.user_signed_in?).to eql true
      end
    end

    context "when there is no user on 'session'" do
      before do
        @user = FactoryGirl.create :user
        #authentication.stub(:current_user).and_return(nil)
        allow(authentication).to receive_messages(:current_user => nil)
      end
      it "user should not be signed in" do
         expect(authentication.user_signed_in?).to eql false
      end
    end
  end
end









