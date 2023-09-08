class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  
  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    if @cart_item.save
      redirect_to cart_items_path
    else
      @item = Item.find(@cart_item.item_id)
      render 'public/items/show'
    end
  end
  
  def index
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @total = 0
  end
  
  def update
    @cart_items = CartItem.find(params[:id])
    if @cart_items.update(cart_item_params)
      redirect_to cart_items_path
    else
      render 'index'
    end
  end
  
  def destroy_all
    customer = Customer.find(current_customer.id)
    if customer.cart_items.destroy_all
      redirect_to cart_items_path
    else
      render 'index'
    end
  end
  
  def destroy
    @cart_items = CartItem.find(params[:id])
    if @cart_items.destroy
      redirect_to cart_items_path
    else
      render 'index'
    end
  end
  
  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id)
  end
end
