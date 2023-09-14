class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details
  has_many :items, through: :order_details
  # has_many :cart_items

  validates :customer_id,presence: true
  validates :postcode, presence: true, length: {is: 7}, numericality: { only_integer: true}
  validates :address, presence:true
  validates :name, presence:true
  validates :postage, presence:true, numericality: {only_integer: true}
  validates :payment, presence:true, numericality: {only_integer: true}
  validates :payment_method, presence:true
  validates :order_status, presence:true

  enum payment_method: {クレジットカード:0, 銀行振込:1 }
  enum order_status: {入金待ち: 0, 入金確認:1, 製作中:2, 発送準備中:3, 発送済み:4}
end
