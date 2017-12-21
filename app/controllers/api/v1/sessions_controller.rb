class Api::V1::SessionsController < Devise::SessionsController
  before_action :api_authenticate!
  skip_before_action :verify_signed_out_user, only: [:destroy]
  acts_as_token_authentication_handler_for User, only: [:destroy]

  def create
    resource = User.find_for_database_authentication(
      email: login_params[:email]
    )

    return invalid_login_attempt unless resource

    if resource.valid_password?(login_params[:password])
      sign_in(:user, resource)
      return render json: {
        success: true,
        authentication_token: resource.authentication_token,
        data: resource
      }
    end
    invalid_login_attempt
  end

  def destroy
    if current_user && current_user.update(authentication_token: nil) && sign_out(resource_name)
      render json: {message: "successfully signed out"}
    else
      render json: {error: "you are not logged in"}
    end
  end

  private
  def login_params
    params.require(:user).permit(:email, :password)
  end

  def invalid_login_attempt
    warden.custom_failure!
    render json: {success: false, message: "Error with your login or password"}, status: 401
  end
end