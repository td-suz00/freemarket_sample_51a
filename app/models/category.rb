class Category < ApplicationRecord

  # 以下某サイトからの引用
  translates :name

  has_many :children, class_name: "Category", foreign_key: "parent_id", dependent: :destroy
  belongs_to :parent, class_name: "Category", foreign_key: "parent_id", optional: true

  # ***************************************
  # 以下のメソッドはUI表示の制御に利用します
  # ***************************************

  # 
  # 引数で指定されたカテゴリが親かどうかの判定
  # 
  def parents?(category)
      current_category = self
      while !current_category.nil?
          return true if current_category.id == category.id 
          current_category = current_category.parent
      end
      false
  end

  # 
  # 親カテゴリーの一覧を取得します
  # 
  def parents
      parents = []
      current_category = self
      while !current_category.parent.nil?
          parents << current_category.parent
          current_category = current_category.parent
      end
      parents.reverse
  end
end
