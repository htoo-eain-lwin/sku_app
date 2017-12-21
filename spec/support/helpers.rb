module Helpers
  def create_api_token
    ApiToken.create(name: "testing",access_id: "123", hostname: "test.host", secret_key: "abc123" )
  end

  def bypass_apiauth
    expect(controller).to receive(:api_authenticate!).and_return(true)
  end

  def login_user
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @current_user = FactoryBot.create(:user)
    sign_in @current_user
    @current_user
  end

  def login_api_user
    user = login_user
    allow(controller.request).to receive(:headers).and_return({
      "X-User-Email" => user.email,
      "X-User-Token" => user.authentication_token})
    user
  end
end