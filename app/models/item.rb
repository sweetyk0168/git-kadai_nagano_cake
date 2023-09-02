class Item < ApplicationRecord
  validates :name, presence: true
  validates :introduction, presence:true
  validates :price, presence:true
  enum is_active: {販売中:0,販売停止:1}
  has_one_attached :image
  validates :image, presence: true
end
