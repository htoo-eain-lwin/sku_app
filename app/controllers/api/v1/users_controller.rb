class Api::V1::UsersController < ApplicationController
  before_action :api_authenticate!

  acts_as_token_authentication_handler_for User, except: [:index, :show]

  def index
    users = User.all.page(params[:page]).per(10)
    render json: {
      data: users,
      meta: {
        total_result: users.count,
        has_next_page: users.total_pages >  users.current_page
      }
    },status: 200
  end

  def show
    @user = User.find(params[:id])
    render json: {
      data: {
          email: @user.email,
          roles: @user.roles.pluck(:name).join(',')
        }
      },status: 200
  end
end
