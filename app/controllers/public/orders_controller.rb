class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
    #@addresses = current_customer.addresses
  end

  def confirm
    @cart_items = current_customer.cart_items

    @order = Order.new(
      #customer: current_customer,
      payment_method:params[:order][:payment_method])
      @order.postage = 800

    #@order.payment = current_customer.payment

    if params[:order][:my_address] == "1"
      @order.postcode = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    #elsif params[:order][:my_address] == "2"
     #ship = Address.find(params[:order][:customer_id])
      #@order.postal_code = ship.postal_code
      #@order.address = ship.address
      #@order.name = ship.name
    elsif params[:order][:my_address] == "3"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    end
  end

  def complete
  end

  def create
    @order = current_customer.orders.new(order_params)
    @order.customer_id = current_customer.id
    @order.save

    #カートを空にするため、order_detailに保存する
    #カート内商品を１つずつ取り出しループ
    current_customer.cart_items.each do |cart_item|
      #初期化宣言
      @order_detail = OrderDetail.new
      #order注文idを紐づけておく
      @order_detail.order_id = @order.id
      #カート内商品idを注文商品idに代入
      @order_detail.item_id = cart_item.item_id
      #カート内商品の個数を注文商品の個数に代入
      @order_detail.amount = cart_item.amount
      #消費税込に計算して代入
      @order_detail.price = ((cart_item.item.add_tax_sales_price*cart_item.amount)*1.1).to_i
      #注文商品を保存
      @order_detail.save
    end
    current_customer.cart_items.destroy_all
    redirect_to complete_orders_path
  end

  def index
    @orders = current_customer.orders.all.page(params[:page]).per(6).order('created_at DESC')
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
  end

  private
  def order_params
    params.require(:order).permit(:postcode, :address, :name, :postage, :payment, :payment_method, :price)
  end

  def address_params
    params.require(:order).permit(:postal_code, :address, :name)
  end
end
