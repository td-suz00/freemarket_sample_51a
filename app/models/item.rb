class Item < ApplicationRecord

  belongs_to :category

  has_many :item_images, dependent: :destroy
  accepts_nested_attributes_for :item_images
  has_one :deal
  belongs_to :category
  belongs_to :size
  belongs_to :brand, optional: true
end
