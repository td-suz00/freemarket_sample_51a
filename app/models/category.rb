class Category < ApplicationRecord
  has_many :children, class_name: "Category", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Category", foreign_key: "parent_id", optional: true, depentent: :destroy
  has_many :items
  has_many :size_categories
  has_many :sizes, through: :size_categories

end
