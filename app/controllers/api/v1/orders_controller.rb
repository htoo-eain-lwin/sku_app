class Api::V1::OrdersController < ApplicationController
  before_action :set_order, only: [:show,:update,:destroy]
  acts_as_token_authentication_handler_for User, except: [:index, :show]

  def index
    if params[:scope] && OrderOptions.include?(params[:scope])
      @orders = Order.send params[:scope]
    else
      @orders = Inventory.all.page(params[:page]).per(10)
    end
    render json: {
      data: @orders,
      meta: {
        total_result: @orders.count,
        has_next_page: @orders.total_pages >  @orders.current_page
      }
    },status: 200
  end

  def show
    render json: {
      data: {
        inventory: {id: @order.inventory_id},
        total: @order.total,
        customer: {id: @order.customer_id, email: @order.customer.email},
        sales_person: {id: @order.sales_person_id, email: @order.sales_person.email}
        }
      },status: 200
  end

  def create
    @order = Order.new(order_params)
    authorize @order
    if @order.save
      render json: {
        success: true,
        data: @order
      },status: 202
    else
      render json: {
        success: false,
        errors: @order.errors
      },status: 422
    end
  end

  def update
    authorize @order
    if @order.update(order_params)
      render json: {
        success: true,
        data: @order
      },status: 201
    else
      render json: {
        success: false,
        errors: @order.errors
      },status: 422
    end
  end

  def destroy
    authorize @order
    if @order.destroy
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

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(
      :inventory_id,
      :total,
      :shipping_status,
      :customer_id,
      :sales_person_id
    )
  end
end
