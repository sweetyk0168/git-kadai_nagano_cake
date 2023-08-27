class Public::CustomersController < ApplicationController
  def new
    @customer = Customer.new
  end

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email)
  end
end
