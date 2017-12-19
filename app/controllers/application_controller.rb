class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ActionController::Caching

  include Pundit
  include APIAuthenticatable
  before_action :api_authenticate!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private
    def user_not_authorized
      respond_to do |format|
        format.json{ render json: {success: false}, status: :unauthorized}
      end
    end

  protected
    def page_param
      params[:page] = "1" if params[:page].nil?
      return Integer(params[:page])
    end
end
