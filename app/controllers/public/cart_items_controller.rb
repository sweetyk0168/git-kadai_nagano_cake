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
       @sum_amount = @in_cart_item.amount + params[:cart_item][:amount].to_i
       @in_cart_item.update(amount: @sum_amount)
       redirect_to cart_items_path
    else
      #新しいカートの作成
      @cart_item = CartItem.new(cart_item_params)
      #誰のカートか紐づけ
      @cart_item.customer_id = current_customer.id
      #情報を保存できるか？
      @cart_item.save!
      #カートページ遷移
      flash[:notice] = "商品をカートに追加しました。"
      redirect_to cart_items_path
    end
  end

  def update
    @cart_items = CartItem.find(params[:id])
    if @cart_items.update(cart_item_params)
      flash[:notice] = "個数を変更しました。"
      redirect_to cart_items_path
    else
      flash[:notice] = "個数の変更に失敗しました。"
      render 'index'
    end
  end

  def destroy
    @cart_items = CartItem.find(params[:id])
    if @cart_items.destroy
      flash[:notice] = "商品の削除が完了しました。"
      redirect_to cart_items_path
    else
      flash[:notice] = "商品の削除が出来ませんでした。"
      render 'index'
    end
  end

  def destroy_all
    customer = Customer.find(current_customer.id)
    if customer.cart_items.destroy_all
      flash[:notice] = "カート内の商品を全て削除しました。"
      redirect_to cart_items_path
    else
      flash[:notice] = "カート内の商品を削除出来ませんでした。"
      render 'index'
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id)
  end
end