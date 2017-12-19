module Helpers
  def create_api_token
    ApiToken.create(name: "testing",access_id: "123", hostname: "test.host", secret_key: "abc123" )
  end
end