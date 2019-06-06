class Item < ApplicationRecord
  belongs_to :category
  has_many :item_images, dependent: :destroy
  accepts_nested_attributes_for :item_images
  has_one :deal
  belongs_to :category
  belongs_to :size, optional: true
  belongs_to :brand, optional: true
  with_options presence: true do
    validates :name
    validates :text
    validates :price 
    validates :category_id
    validates :condition
    validates :delivery_fee_payer
    validates :delivery_type 
    validates :delibery_from_area
    validates :delivery_days
  end
validates :price, numericality: {greater_than_or_equal_to: 300,less_than_or_equal_to: 9_999_999}
end