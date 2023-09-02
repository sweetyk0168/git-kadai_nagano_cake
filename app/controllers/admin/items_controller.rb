class Admin::ItemsController < ApplicationController
  layout 'admin_header'
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_items_path(@item)
    else
      render "new"
    end
  end
  
  def show
    
  end

  def edit
  end
  
  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :price, :is_active, :image)
  end
end
