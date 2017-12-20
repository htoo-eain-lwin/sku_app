require 'rails_helper'
include RoutingMacros
describe API::V1, :type => :routing do
  let(:url_options) { {format: "json", subdomain: "api"} }

  describe "users" do
    it "routes to index" do
      expect(api_get "/users.json").
        to route_to( "api/v1/users#index", url_options)
    end
    it "routes to show" do
      expect(api_get "/users/1.json").
        to route_to( "api/v1/users#show", url_options.merge(id: "1"))
    end
  end

  describe "products" do
    it "routes to index" do
      expect(api_get "/products.json").
        to route_to( "api/v1/products#index", url_options)
    end
    it "routes to show" do
      expect(api_get "/products/1.json").
        to route_to( "api/v1/products#show", url_options.merge(id: "1"))
    end
    it "routes to create" do
      expect(api_post "/products.json").
        to route_to( "api/v1/products#create", url_options)
    end
    it "routes to update" do
      expect(api_put "/products/1.json").
        to route_to( "api/v1/products#update", url_options.merge(id: "1"))
    end
    it "routes to destroy" do
      expect(api_delete "/products/1.json").
        to route_to( "api/v1/products#destroy", url_options.merge(id: "1"))
    end
  end

  describe "#devise" do
    it "routes to login" do
      expect(api_post "/login.json").
        to route_to( "api/v1/sessions#create", url_options)
    end

    it "routes to logout" do
      expect(api_delete "/logout.json").
        to route_to( "api/v1/sessions#destroy", url_options)
    end
  end
end