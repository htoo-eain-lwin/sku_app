require "rails_helper"

describe Api::V1::InventoriesController, :type => :controller do
  before(:example) do
    bypass_apiauth
    login_api_user
    @current_user.add_role(:admin)
  end

  describe "#index" do
    it "give all inventories" do
      FactoryBot.create(:inventory)
      get :index, params: {format: :json}
      expect(response).to  have_http_status(200)
      expect(assigns(:inventories).empty?).to eq(false)
    end

    it "return per scope param" do
      dist = FactoryBot.create :distribution_center, name: "Singapore"
      ware = FactoryBot.create :warehouse, distribution_center_id: dist.id
      FactoryBot.create(:inventory, warehouse_id: ware.id)
      get :index, params: {format: :json, scope: "Singapore"}
      expect(response).to  have_http_status(200)
      expect(assigns(:inventories).empty?).to eq(false)
    end

    it "return empty if no inventories" do
      FactoryBot.create :distribution_center, name: "Singapore"
      get :index, params: {format: :json, scope: "Singapore"}
      expect(response).to  have_http_status(200)
      expect(assigns(:inventories).empty?).to eq(true)
    end
  end

  describe "#show" do
    it "show inventory" do
      inventory = FactoryBot.create(:inventory)
      get :show, params: {format: :json, id: inventory.id}
      expect(response).to  have_http_status(200)
      expect(assigns(:inventory)).to  eq(inventory)
    end
  end

  describe "#create" do
    it "create the inventory" do
      product = FactoryBot.create :product
      warehouse = FactoryBot.create :warehouse
      post :create, params: { inventory: {product_id: product.id, warehouse_id: warehouse.id, count: 110}}
      expect(response).to  have_http_status(202)
    end
  end

  describe "#update" do
    it "update inventory" do
      inventory = FactoryBot.create(:inventory,count: 100)
      put :update, params: {format: :json, id: inventory.id, inventory: {count: 111}}
      expect(response).to  have_http_status(201)
      expect(assigns(:inventory).count).to  eq(111)
    end
  end

  describe "#destroy" do
    it 'should delete saved search' do
      inventory = FactoryBot.create(:inventory)
      delete :destroy, params: { format: :json, id: inventory.id }
      expect(response).to  have_http_status(200)
    end
  end
end