class Item < ApplicationRecord
  belongs_to :genre
  validates :name, presence: true
  validates :introduction, presence:true
  validates :price, presence:true
  #validates :is_active, inclusion:{in:["販売中":true, "販売停止":false]}
  validates :is_active, inclusion:[true, false]
  has_one_attached :image
  validates :image, presence: true

  def add_tax_sales_price
    (self.price * 1.10).round
  end
  
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'sample-author.jpg', content_type: 'image/jpeg')
    end
      image.variant(resize_to_limit: [width, height]).processed
  end
end
