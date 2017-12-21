require 'rails_helper'

describe Api::V1::SessionsController, :type => :controller do
  before :example do
    bypass_apiauth
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "#create" do
    context "when user's email doesn't exist" do
      it "returns invalid login attempt" do
        params_to_submit = FactoryBot.attributes_for :user
        post :create, params: {:format => :json, user: params_to_submit}
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:success]).to be(false)
      end
    end

    context "when user's email and password correct" do
      it "login user" do
        user = FactoryBot.create :user
        post :create, params: {:format => :json, user: {email: user.email,password: user.password }}
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:success]).to be(true)
      end
    end

    context "when user's email exist but doesn't provide correct password" do
      it "returns invalid_login_attempt with email" do
        params_to_submit = FactoryBot.attributes_for(:user,{email: "testuser@email.com"})
        post :create, params: {:format => :json, user: params_to_submit}
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:success]).to be(false)
        expect(body[:message]).to eq("Error with your login or password")
      end
    end
  end

  describe "#destroy" do
    context "when user is logged out" do
      before  :example do
        login_api_user
        delete :destroy,{:format => :json}
      end

      it "logs user out" do
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:message]).to eq("successfully signed out")
      end

      it "gives message" do
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:message]).not_to be_nil
      end
    end

    context "when user isn't logged in" do
      it "gives error" do
        delete :destroy, params: {:format => :json}
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:error]).to eq("you are not logged in")
      end
    end
  end
end