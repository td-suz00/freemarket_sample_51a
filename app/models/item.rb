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


  # ピックアップカテゴリーのitemsの配列を生成するメソッド
  def self.pickup_category_items(id)
    # 引数で渡されたidの子カテゴリのidの配列を生成
    child_category_ids = Category.find(id).children.ids
    # 子カテゴリのidと合致する孫カテゴリのidの配列を生成
    grand_child_category_ids = Category.where("parent_id IN (?)", child_category_ids).ids
    # 孫カテゴリのidと合致するitemsの配列を生成
    items = Item.where("category_id IN (?)", grand_child_category_ids)
    # 最新の４件を取得
    items.order("created_at DESC").limit(4)
  end

  # ピックアップブランドのitemsの配列を生成するメソッド
  def self.pickup_brand_items(brand_name)
    pickup_brand_id = Brand.find_by(name: brand_name).id
    Item.where(brand_id: pickup_brand_id).order("created_at DESC").limit(4)
  end

end
