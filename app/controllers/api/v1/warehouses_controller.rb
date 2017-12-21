class Api::V1::WarehousesController < ApplicationController
  before_action :api_authenticate!
  before_action :set_warehouse, only: [:show,:update,:destroy]
  acts_as_token_authentication_handler_for User, except: [:index, :show]

  def index
    warehouses = Warehouse.all.page(params[:page]).per(10)
    render json: {
      data: warehouses,
      meta: {
        total_result: warehouses.count,
        has_next_page: warehouses.total_pages >  warehouses.current_page
      }
    },status: 200
  end

  def show
    render json: {
      data: {
        name: @warehouse.name,
        distribution_center_id: @warehouse.distribution_center_id,
        }
      },status: 200
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)
    authorize @warehouse
    if @warehouse.save
      render json: {
        success: true,
        data: @warehouse
      },status: 202
    else
      render json: {
        success: false,
        errors: @warehouse.errors
      },status: 422
    end
  end

  def update
    authorize @warehouse
    if @warehouse.update(warehouse_params)
      render json: {
        success: true,
        data: @warehouse
      },status: 201
    else
      render json: {
        success: false,
        errors: @warehouse.errors
      },status: 422
    end
  end

  def destroy
    authorize @warehouse
    if @warehouse.destroy
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

  def set_warehouse
    @warehouse = Warehouse.find(params[:id])
  end

  def warehouse_params
    params.require(:warehouse).permit(
      :name,
      :distribution_center_id
    )
  end
end
