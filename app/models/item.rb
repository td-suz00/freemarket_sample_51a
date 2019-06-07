class Item < ApplicationRecord
  belongs_to :category
  has_many :item_images, dependent: :destroy
  accepts_nested_attributes_for :item_images
  has_one :deal
  belongs_to :category
  belongs_to :size, optional: true
  belongs_to :brand, optional: true
  with_options presence: true do
    validates :name, :text, :price, :category_id, :condition, :delivery_fee_payer, :delivery_type, :delibery_from_area, :delivery_days
  end
validates :price, numericality: {greater_than_or_equal_to: 300,less_than_or_equal_to: 9_999_999}

  def choose_redies_items(items)
    redies_items = items.where(category.parent.parent.name: "レディース")
  end

end
