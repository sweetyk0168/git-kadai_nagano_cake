class Public::HomesController < ApplicationController

  def top
    @items = Item.order(id: "DESC").limit(4)
  end

  def about
  end

  def unsubscribe
    @customer = Customer.find_by(name: params[:name])
  end

  def withdraw
    @customer = Customer.find_by(name: params[:name])
    @customer.update(id_valid: false)
    reset_session
    redirect_to root_path
  end
end
