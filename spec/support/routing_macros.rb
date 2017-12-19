module RoutingMacros

  def url
    "http://api.sku.dev:3000/v1"
  end
  %w[get post put patch delete options head].each do |method|
    define_method "api_#{method}" do |path|
      { method.to_sym => "#{url}#{path}" }
    end
  end

end
