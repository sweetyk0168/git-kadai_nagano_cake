class Item < ApplicationRecord
  belongs_to :genre
  validates :name, presence: true
  validates :introduction, presence:true
  validates :price, presence:true
  #validates :is_active, inclusion:{in:["販売中":true, "販売停止":false]}
  validates :is_active, inclusion:[true, false]
  has_one_attached :image
  validates :image, presence: true
end
