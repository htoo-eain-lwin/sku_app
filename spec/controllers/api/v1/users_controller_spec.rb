require 'rails_helper'

describe Api::V1::UsersController, :type => :controller do

  describe "#index" do
    it "should render users" do
      bypass_apiauth
      get :index, params: { format: :json }
      expect(response.status).to eq(200)
    end
  end
end