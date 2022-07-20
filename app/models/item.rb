class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  belongs_to :genre

  def get_item_image(width, height)
  unless item_image.attached?
    file_path = Rails.root.join('app/assets/images/cookie.png')
    file_path = Rails.root.join('app/assets/images/hotcake.png')
    file_path = Rails.root.join('app/assets/images/pudding.png')
    item_image.attach(io: File.open(file_path), filename: 'default-image.png', content_type: 'image/png')
  end
  item_image.variant(resize_to_limit: [width, height]).processed
  end
end
