class Api::V1::UsersController < ApplicationController
  before_action :api_authenticate!
  acts_as_token_authentication_handler_for Product, except: [:index, :show]
  def index
    products = Product.all.page(params[:page]).per(10)
    render json: {
      data: products,
      meta: {
        total_result: products.count,
        has_next_page: products.total_pages >  products.current_page
      }
    },status: 200
  end

  def show
  end

end
