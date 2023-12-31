class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  # belongs_to :order

  validates :amount, presence:true
  validates :item_id, presence:true
  validates :customer_id, presence:true

  def subtotal
    item.add_tax_sales_price * amount
  end
end
