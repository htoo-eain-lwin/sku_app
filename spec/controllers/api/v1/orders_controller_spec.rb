require "rails_helper"

describe Api::V1::OrdersController, :type => :controller do
  before(:example) do
    bypass_apiauth
    login_api_user
    @current_user.add_role(:admin)
  end

  describe "#index" do
    it "give all orders" do
      FactoryBot.create(:order)
      get :index, params: {format: :json}
      expect(response).to  have_http_status(200)
    end
  end

  describe "#show" do
    it "show order" do
      inventory = FactoryBot.create(:inventory)
      customer = FactoryBot.create(:customer)
      sales_person = FactoryBot.create(:sales_person)
      order = FactoryBot.create(:order, inventory_id: inventory.id, customer_id: customer.id, sales_person_id: sales_person.id)
      get :show, params: {format: :json, id: order.id}
      expect(response).to  have_http_status(200)
      expect(assigns(:order)).to  eq(order)
    end
  end

  describe "#create" do
    it "create the order" do
      inventory = FactoryBot.create(:inventory)
      customer = FactoryBot.create(:customer)
      sales_person = FactoryBot.create(:sales_person)
      post :create, params: { order: {inventory_id: inventory.id, customer_id: customer.id, total: 1, sales_person_id: sales_person.id, shipping_status: "pending"}}
      expect(response).to  have_http_status(202)
    end
  end

  describe "#update" do
    it "update order" do
      order = FactoryBot.create(:order)
      put :update, params: {format: :json, id: order.id, order: {shipping_status: "reserved"}}
      expect(response).to  have_http_status(201)
      expect(assigns(:order).shipping_status).to  eq("reserved")
    end
  end

  describe "#destroy" do
    it 'should delete saved search' do
      order = FactoryBot.create(:order)
      delete :destroy, params: { format: :json, id: order.id }
      expect(response).to  have_http_status(200)
    end
  end
end

