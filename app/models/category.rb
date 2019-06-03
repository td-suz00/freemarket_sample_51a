class Category < ApplicationRecord
  has_many :children, class_name: "Category", foreign_key: "parent_id", depentent: :destroy
  belongs_to :parent, class_name: "Category", foreign_key: "parent_id", optional: true
  has_many :items
  has_many :size_categories
  has_many :sizes, through: :size_categories

end
