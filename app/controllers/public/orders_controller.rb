class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  
  def new
    @order = Order.new
    #@addresses = current_customer.addresses
  end

  def confirm
    @cart_items = current_customer.cart_items

    @order = Order.new(
      customer: current_customer,
      payment_method:params[:order][:payment_method])
      @order.postage = 800

    #@order.payment = current_customer.payment

    if params[:order][:my_address] == "1"
      @order.postcode = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name

    elsif params[:order][:my_address] == "2"
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
    
    #カートを空にするため、ordered_itemに保存する
    current_customer.cart_items.each do |cart_item|
    end
  end

  def index
  end

  def show
  end

  private
  def order_params
    params.require(:order).permit(:post_code, :address, :name, :postage, :payment, :payment_method)
  end

  def address_params
    params.require(:order).permit(:post_code, :address, :name)
  end
end
