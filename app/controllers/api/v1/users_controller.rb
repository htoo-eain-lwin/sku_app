class Api::V1::UsersController < ApplicationController
  before_action :api_authenticate!
  acts_as_token_authentication_handler_for User, except: [:index, :show]
  def index
    users = User.all
    render json: {data: users},status: 200
  end
end
