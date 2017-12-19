module RoutingMacros

  def url
    "http://api.sku.dev:3000/v1"
  end
  %w[get post put patch delete options head].each do |method|
    define_method "api_#{method}" do |path|
      { method.to_sym => "#{url}#{path}" }
    end
    define_method "apiv2_#{method}" do |path|
      { method.to_sym => "#{url_v2}#{path}" }
    end
    define_method "lite_#{method}" do |path|
      { method.to_sym => "#{url_lite}#{path}" }
    end
    define_method "club_#{method}" do |path|
      { method.to_sym => "#{url_club}#{path}" }
    end
  end

end
