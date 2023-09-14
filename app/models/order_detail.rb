class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  
  validates :item_id, presence:true
  validates :order_id, presence:true
  validates :amount, presence:true, numericality: { only_integer: true }
  validates :price, presence:true, numericality: { only_integer: true }
  enum production_status: {"着手負荷":0, "製作待ち":1, "製作中":2, "製作完了":3}
end
