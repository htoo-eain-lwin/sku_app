class PopulateUsersService
  def self.call
    admin = User.find_or_create_by(email: Figaro.env.sku_admin_email) do |user|
      user.password = Figaro.env.sku_admin_password
    end
    admin.add_role :admin
  end
end