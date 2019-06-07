class Item < ApplicationRecord
  has_many :item_images
  accepts_nested_attributes_for :item_images
  has_one :deal
  belongs_to :category
  belongs_to :size
  belongs_to :brand

  def choose_redies_items(items)
    redies_items = items.where(category.parent.parent.name: "レディース")
  end

end
