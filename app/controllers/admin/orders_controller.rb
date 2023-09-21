class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin_header'

  def index
    @orders = Order.all.page(params[:page]).per(10).order('created_at DESC')
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    @order_details = @order.order_details

    if @order.order_status == "入金確認"
        @order_details.each do |order_detail|
        order_detail.production_status = "製作待ち"
        order_detail.save

      end
      #@order.order_details.update_all(production_status: 1)
    end
    redirect_to admin_order_path(@order.id)
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postcode, :address, :name, :postage, :payment, :payment_method, :order_status)
  end
end
