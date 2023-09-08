class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  before_action :cart_item_item?, only: [:create]
  
  def index
    @cart_items = current_customer.cart_items
    @total = 0
  end
  
  def create
    #カート内に商品があるか？
    if current_customer.cart_items.count >= 1
      #カートに入れた商品はすでにカートに追加済か？
      if nil != current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
        #カート内のすでにある商品の情報取得
        @cart_item_u = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
        #既にある情報に個数を合算
        @cart_item_u.number_of_items += params[:cart_item][:number_of_items].to_i
        #情報の更新 個数カラム
        @cart_item_u.update(number_of_items: @cart_item_u.number_of_items)
        #カートページ遷移
        redirect_to_cart_items_path
      else
        #新しいカートの作成
        @cart_item = CartItem.new(cart_item_params)
        #誰のカートか紐づけ
        @cart_item.customer_id = current_customer.id
        #情報を保存できるか？
        if @cart_item.save
          #カートページ遷移
          redirect_to cart_items_path
        else
          #販売ステータスが「０」のものを見つける
          @item = Item.where(sale_status: 0).page(params[:page]).per(8)
          #商品の数をカウント
          @amount = Item.count
          #有効、無効ステータスが0のものを見つける
          @genres = Genre.where(is_deleted: 0)
          render 'index'
        end
      end
    else
      #新しくカートの作成
      @cart_item = CartItem.new(cart_item_params)
      #誰のカートか紐づけ
      @cart_item.customer_id = current_customer.id
      #情報を保存できるか？
      if @cart_item.save
        #カートページ遷移
        redirect_to cart_items_path
      else
        @items = Item.where(is_active: 0).page(params[:page]).per(8)
        #商品の数をカウント
        @amount = Item.count
        #有効、無効ステータスが0のものを見つける
        @genres = Genre.where(is_deleted: 0)
        render 'index'
      end
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
  
  def cart_item_item?
    redirect_to cart_item_path(params[:cart_item][:item_id]), notice: "個数を入力してください。"if params[:cart_item][:number_of_items].empty?
  end
  
  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id)
  end
end