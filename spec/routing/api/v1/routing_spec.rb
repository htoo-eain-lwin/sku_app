require 'rails_helper'
include RoutingMacros
describe API::V1, :type => :routing do
  let(:url_options) { {format: "json", subdomain: "api"} }

  it "routes to /users" do
    expect(api_get "/users.json").
      to route_to( "api/v1/users#index", url_options)
  end

end