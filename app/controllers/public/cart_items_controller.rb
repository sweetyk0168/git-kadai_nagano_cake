class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  
  def index
    @cart_items = current_customer.cart_items
    @total = 0
  end
  
  def create
  #カート内に同一商品があるか？
    @in_cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
    if @in_cart_item
       @sum_amount = @in_cart_item.number_of_items + params[:cart_item][:number_of_items].to_i
       @in_cart_item.update(number_of_items: @sum_amount)
       redirect_to cart_items_path
    else
      #新しいカートの作成
      @cart_item = CartItem.new(cart_item_params)
      #誰のカートか紐づけ
      @cart_item.customer_id = current_customer.id
      #情報を保存できるか？
      @cart_item.save
      #カートページ遷移
      redirect_to cart_items_path
    end
  end

  def update
    @cart_items = CartItem.find(params[:id])
    if @cart_items.update(cart_item_params)
      redirect_to cart_items_path
    else
      render 'index'
    end
  end
  
  def destroy
    @cart_items = CartItem.find(params[:id])
    @cart_items.destroy
    redirect_to cart_items_path
  end
  
  def destroy_all
    customer = Customer.find(current_customer.id)
    customer.cart_items.destroy_all
    redirect_to cart_items_path
  end
  
  private
  
  
  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id)
  end
end