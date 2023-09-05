class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page])
    @quantity = Item.count
  end
  
  def show
    @item = Item.find(params[:id])
    #@post_images = @item.post_images.page(params[:page])
  end
end
