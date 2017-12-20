class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ActionController::Caching

  include Pundit
  include APIAuthenticatable
  before_action :api_authenticate!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :object_not_found

  private
    def user_not_authorized
      render json: {success: false}, status: :unauthorized
    end

    def object_not_found
      render json: {success: false, message: "Object not found" }, status: :not_found
    end

  protected
    def page_param
      params[:page] = "1" if params[:page].nil?
      return Integer(params[:page])
    end
end
