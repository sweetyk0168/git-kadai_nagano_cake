class Public::CustomersController < ApplicationController
  def new
    @customer = Customer.new
    # if customer.save
    #   redirect_to customers_path
    # end
  end
  
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = Customer.find(current_customer.id)
    if @customer.update(customer_params)
      redirect_to customers_path(@customer)
    else
      render 'edit'
    end
  end

  def confirm_withdraw
  end

  def withdraw
    #is_deletedカラムをtrueに変更することにより削除フラグを立てる
    current_customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end
  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email)
  end
end
