class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin_header'
  def index
    @orders = Order.page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end
  
  def order_params
    params.require(:order).permit(:customer_id, :postcode, :address, :name, :postage, :payment, :payment_method, :order_status)
  end
end
