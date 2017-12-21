require "rails_helper"

describe Api::V1::WarehousesController, :type => :controller do
  before(:example) do
    bypass_apiauth
    login_api_user
    @current_user.add_role(:admin)
  end

  describe "#index" do
    it "give all warehouses" do
      warehouse = FactoryBot.create(:warehouse)
      get :index, params: {format: :json}
      expect(response).to  have_http_status(200)
    end
  end

  describe "#show" do
    it "show warehouse" do
      warehouse = FactoryBot.create(:warehouse)
      get :show, params: {format: :json, id: warehouse.id}
      expect(response).to  have_http_status(200)
      expect(assigns(:warehouse)).to  eq(warehouse)
    end
  end

  describe "#create" do
    it "create the warehouse" do
      distribution = FactoryBot.create :distribution_center
      post :create, params: { warehouse: {name: "warehouse", distribution_center_id: distribution.id}}
      expect(response).to  have_http_status(202)
    end
  end

  describe "#update" do
    it "update warehouse" do
      warehouse = FactoryBot.create(:warehouse,name: "Django")
      put :update, params: {format: :json, id: warehouse.id, warehouse: {name: "Sinatra"}}
      expect(response).to  have_http_status(201)
      expect(assigns(:warehouse).name).to  eq("Sinatra")
    end
  end

  describe "#destroy" do
    it 'should delete saved search' do
      warehouse = FactoryBot.create(:warehouse)
      delete :destroy, params: { format: :json, id: warehouse.id }
      expect(response).to  have_http_status(200)
    end
  end
end

