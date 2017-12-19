module APIAuthenticatable
  AUTH_ERROR_MESSAGE = "API Authentication failed"
  def api_authenticate!
    return true if skip?
    if !params[:api_key].nil?
      set_cors_headers
    else
      render json: {error: AUTH_ERROR_MESSAGE}, status: :unauthorized
      return false
    end
  end

  private

  def set_cors_headers
    is_auth_url = false
    @apitoken = ApiToken.find_by(access_id: params[:api_key])
    origin = request.host
    url = "%s%s" % [request.protocol, @apitoken.hostname]
    if @apitoken &&
      !origin.nil? &&
      origin == URI.parse(url).host
      response.headers.merge!(
        "Access-Control-Allow-Origin" => url,
        "Access-Control-Allow-Methods" => %w{GET POST PUT DELETE OPTIONS}.join(","),
        "Access-Control-Allow-Headers" => "Origin, X-Requested-With,  X-User-Email, X-User-Token, Content-Type, Accept"
        )
      is_auth_url = true
    else
      render json: {error: AUTH_ERROR_MESSAGE}, status: :unauthorized
    end
    is_auth_url
  end

  def skip?
    params[:api_auth_skip]
  end
end
