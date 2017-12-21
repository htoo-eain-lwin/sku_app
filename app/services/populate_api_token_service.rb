class PopulateApiTokenService
  def self.call
    ApiToken.destroy_all
    ApiToken.create(name: "local", hostname: "api.sku.dev")
  end
end

