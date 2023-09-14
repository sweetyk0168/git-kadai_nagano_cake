class Address < ApplicationRecord
  belongs_to :customer

  validates :customer_id, presence:true
  validates :postal_code, presence:true, length: { is: 7 }, numericality: { only_integer: true }
  validates :address, presence:true
  validates :telephone_number, presence:true
  validates :name, presence:true

  #配送先住所情報の統合
  def address_all
    '〒' + postal_code + '' + address + '' + name
  end
end
