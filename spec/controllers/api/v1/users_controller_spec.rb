require 'rails_helper'

describe Api::V1::UsersController, :type => :controller do

  describe "#index" do
    it "should render users" do
      bypass_apiauth
      get :index, params: { format: :json }
      expect(response.status).to eq(200)
    end
  end

  describe "#show" do
    it "should render user" do
      bypass_apiauth
      user = FactoryBot.create :user
      get :show, params: { id: user.id, format: :json }
      expect(response.status).to eq(200)
      expect(assigns(:user)).to eq(user)
    end
  end
end