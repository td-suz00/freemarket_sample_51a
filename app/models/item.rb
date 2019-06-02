class Item < ApplicationRecord

  belongs_to :buyer, class_name: 'User', foreign_key: 'buyer_id', optional: true
  belongs_to :seller, class_name: 'User', foreign_key: 'seller_id'

  belongs_to :category

  has_many :item_images, dependent: :destroy
  accepts_nested_attributes_for :item_images
  
end
