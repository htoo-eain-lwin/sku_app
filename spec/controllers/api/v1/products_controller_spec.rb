require "rails_helper"

describe Api::V1::ProductsController, :type => :controller do
  before(:example) do
    bypass_apiauth
    login_api_user
    @current_user.add_role(:admin)
  end

  describe "#index" do
    it "give all products" do
      product = FactoryBot.create(:product)
      get :index, params: {format: :json}
      expect(response).to  have_http_status(200)
    end
  end

  describe "#show" do
    it "show product" do
      product = FactoryBot.create(:product)
      get :show, params: {format: :json, id: product.id}
      expect(response).to  have_http_status(200)
      expect(assigns(:product)).to  eq(product)
    end
  end

  describe "#create" do
    it "create the product" do
      post :create, params: { product: FactoryBot.attributes_for(:product)}
      expect(response).to  have_http_status(202)
    end
  end

  describe "#update" do
    it "update product" do
      product = FactoryBot.create(:product,price: 100)
      put :update, params: {format: :json, id: product.id, product: {price: 111}}
      expect(response).to  have_http_status(201)
      expect(assigns(:product).price).to  eq(111)
    end
  end

  describe "#destroy" do
    it 'should delete saved search' do
      product = FactoryBot.create(:product)
      delete :destroy, params: { format: :json, id: product.id }
      expect(response).to  have_http_status(200)
    end
  end
end

