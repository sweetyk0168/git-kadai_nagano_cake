class Admin::OrderDetailsController < ApplicationController
  layout 'admin_header'
  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_details = @order.order_details
    @order_detail.update(order_detail_params)

    #注文ステータスを「製作中」
    if @order_details.where(production_status: "製作中").count >= 1
      @order.order_status = "製作中"
      @order.save
    end

    #注文個数と製作完了になっている個数が同じならば
    if @order.order_details.count == @order_details.where(production_status: "製作完了").count
      @order.order_status = "発送準備中"
      @order.save
    end
    redirect_to admin_order_path(@order_detail.order.id)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:production_status)
  end
end
