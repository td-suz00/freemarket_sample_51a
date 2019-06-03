class Item < ApplicationRecord

  has_many :item_images
  accepts_nested_attributes_for :item_images
  belongs_to :buyer, class_name: 'User', foreign_key: 'buyer_id', optional: true
  belongs_to :seller, class_name: 'User', foreign_key: 'seller_id'
  belongs_to :category
  belongs_to :size
  belongs_to :brand
end
