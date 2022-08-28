class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  belongs_to :customer
  enum payment_method: { クレジットカード: 0, 銀行振込: 1 }

  # 注文ステータス（0=支払待ち / 1=支払済み / 2=発送準備中 / 3=発送済み）
  enum status: {
    支払い待ち: 0,
    支払い済: 1,
    発送準備中: 2,
    発送済: 3
  }
end
