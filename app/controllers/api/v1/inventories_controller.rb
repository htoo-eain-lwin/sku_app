class Api::V1::InventoriesController < ApplicationController
  before_action :set_inventory, only: [:show,:update,:destroy]
  acts_as_token_authentication_handler_for User, except: [:index, :show]

  def index
    @inventories = []
    if scope = params[:scope]
      if scope == "Singapore"
        @inventories = Inventory.from_singapore.page(params[:page]).per(10)
      elsif scope == "Thailand"
        @inventories = Inventory.from_thailand.page(params[:page]).per(10)
      end
    else
      @inventories = Inventory.all.page(params[:page]).per(10)
    end
    render json: {
      data: @inventories,
      meta: {
        total_result: @inventories.count,
        has_next_page: @inventories.total_pages >  @inventories.current_page
      }
    },status: 200
  end

  def show
    render json: {
      data: {
        product: {id: @inventory.product_id, name: @inventory.product.name},
        warehouse: {id: @inventory.warehouse_id, name: @inventory.warehouse.name},
        count: @inventory.count
        }
      },status: 200
  end

  def create
    @inventory = Inventory.new(inventory_params)
    authorize @inventory
    if @inventory.save
      render json: {
        success: true,
        data: @inventory
      },status: 202
    else
      render json: {
        success: false,
        errors: @inventory.errors
      },status: 422
    end
  end

  def update
    authorize @inventory
    if @inventory.update(inventory_params)
      render json: {
        success: true,
        data: @inventory
      },status: 201
    else
      render json: {
        success: false,
        errors: @inventory.errors
      },status: 422
    end
  end

  def destroy
    authorize @inventory
    if @inventory.destroy
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

  def set_inventory
    @inventory = Inventory.find(params[:id])
  end

  def inventory_params
    params.require(:inventory).permit(
      :product_id,
      :warehouse_id,
      :count
    )
  end
end
