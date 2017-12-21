class PopulateProductService
  def self.call
    Product.destroy_all
    50.times.each_with_index do |index|
      Product.create(name: "product #{index}",price: rand(10000..100000))
    end
  end
end