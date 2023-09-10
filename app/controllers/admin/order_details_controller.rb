class Admin::OrderDetailsController < ApplicationController
  layout 'admin_header'
  before_action :authenticate_admin!
  
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    @order = @prder_detail.order
    #redirect_to admin_orders_path
    
    #注文ステータスを「製作中」
    if @order_detail.production_status == "製作中"
      @order.update(status: 2)
      flash[:notice] = "製作ステータスを更新しました"
      @order.save
    end
    
    #注文個数と製作完了になっている個数が同じならば
    if @order.order_details.count == @order.order_details.where(production_status: 3).count
      @order.update(status: 3)
      flash[:notice] = "製作ステータスを更新しました"
      @order.save
    end
    
    redirect_to request.referer
  end
  
  private
  
  def order_detail_params
    params.require(:order_detail).permit(:item_id, :order_id, :amount, :price, :production_status)
  end
end
