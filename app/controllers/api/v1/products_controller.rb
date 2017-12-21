class Api::V1::ProductsController < ApplicationController
  before_action :api_authenticate!
  before_action :set_product, only: [:show,:update,:destroy]
  acts_as_token_authentication_handler_for User, except: [:index, :show]

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
    render json: {
      data: {
        name: @product.name,
        description: @product.description,
        price: @product.price
        }
      },status: 200
  end

  def create
    @product = Product.new(product_params)
    authorize @product
    if @product.save
      render json: {
        success: true,
        data: @product
      },status: 202
    else
      render json: {
        success: false,
        errors: @product.errors
      },status: 422
    end
  end

  def update
    authorize @product
    if @product.update(product_params)
      render json: {
        success: true,
        data: @product
      },status: 201
    else
      render json: {
        success: false,
        errors: @product.errors
      },status: 422
    end
  end

  def destroy
    authorize @product
    if @product.destroy
      render json: {
        success: true,
      },status: :ok
    else
      render json: {
        success: false,
      },status: 422
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(
      :name,
      :price,
      :description,
    )
  end
end
