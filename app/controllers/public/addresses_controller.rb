class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @address = Address.new
    @addresses = Addresses.where(customer_id: current_user.id)
  end

  def create
    @address = Addresss.new(address_params)
    @address.customer_id = current_user.id
    if @address.save
      redirect_to addresses_path
    else
      @addresses = Address.where(customer_id: current_user.id)
      render 'index'
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path
    else
      render 'edit'
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_ to addressed_path
  end

  private
  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end
