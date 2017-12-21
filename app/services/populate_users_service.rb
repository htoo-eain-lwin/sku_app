class PopulateUsersService
  def self.call
    User.destroy_all
    admin = User.create(email: Figaro.env.sku_admin_email) do |user|
      user.password = Figaro.env.sku_admin_password
    end
    admin.add_role :admin
    5.times.each do |i|
      sales = User.create(email: "sales#{i}@email.com",password: Figaro.env.sku_admin_password)
      sales.add_role :sales
    end
    20.times.each do |i|
      sales = User.create(email: "customer#{i}@email.com", password: SecureRandom.hex(8))
      sales.add_role :customer
    end
  end
end