# Users
|Column|Type|Options|
|------|----|-------|
|nickname|STRING|null: false|
|email|STRING|null: false, unique: true|
|encrypted_password|STRING|null: false|

### Association
- has_many :comments
- has_many :post_reviews, foreign_key: :reviewer_id, class_name: :Review
- has_many :receive_reviews, foreign_key: :reviewed_id, class_name: :Review
- has_one :profile
- has_one :card
- has_many :buyed_deals, foreign_key: :buyer_id, class_name: :Deal
- has_many :selling_deals, -> { where("buyer_id is NULL") }, foreign_key: :seller_id, class_name: :Deal
- has_many :sold_deals, -> { where("buyer_id is not NULL") }, foreign_key: :seller_id, class_name: :Deal
- has_many :buyed_items, through: :buyed_deals, source: :item
- has_many :selling_items, through: :selling_deals, source: :item
- has_many :sold_items, through: :sold_deals, source: :item

---
# Profiles
|Column|Type|Options|
|------|----|-------|
|profile_comment|TEXT||
|avatar|STRING||
|family_name|STRING|null: false|
|last_name|STRING|null: false|
|kana_family_name|STRING|null: false|
|kana_last_name|STRING|null: false|
|postalcode|STRING||
|address_prefecture|STRING||
|address_city|STRING||
|address_street_number|STRING||
|address_building_name|STRING||
|birth_ymd|DATE|null: false|
|phone_number|STRING|unique: true|
|user_id|REFERENCES|null: false, foreign_key: true|

### Association
- belongs_to :user

---
# Cards
|Column|Type|Options|
|------|----|-------|
|customer_id|STRING|null: false, unique: true|
|card_id|STRING|null: false, unique: true|
|user_id|REFERENCES|null: false, foreign_key: true|

### Association
- belongs_to :user

---
# Reviews
|Column|Type|Options|
|------|----|-------|
|text|TEXT|null: false|
|grade|STRING|null: false|
|reviewed_id|REFERENCES|null: false, foreign_key: true|
|reviewer_id|REFERENCES|null: false, foreign_key: true|

### Association
- belongs_to :reviewer, class_name: :User
- belongs_to :reviewed, class_name: :User

---
# Items
|Column|Type|Options|
|------|----|-------|
|name|STRING|null: false, index: true|
|size_id|REFERENCES|null: false, foreign_key: true|
|condition|STRING|null: false|
|text|TEXT|null: false|
|price|INTEGER|null: false|
|delivery_fee_payer|STRING|null: false|
|delivery_type|STRING|null: false|
|delibery_from_area|STRING|null: false|
|delivery_days|STRING|null: false|
|category_id|REFERENCES|null: false, foreign_key: true|
|brand_id|REFERENCES|optional: true, foreign_key: true|

### Association
- has_many :comments
- has_many :item_images
- accepts_nested_attributes_for :item_images
- has_one :deal
- belongs_to :size
- belongs_to :category
- belongs_to :brand

---
# Deals
|Column|Type|Options|
|------|----|-------|
|charge_id|STRING|unique: true|
|deal_at|DATETIME||
|buyer_id|REFERENCES|optional: true, foreign_key: true|
|seller_id|REFERENCES|null: false, foreign_key: true|
|status_id|REFERENCES|null: false, foreign_key: true, default: 1|
|item_id|REFERENCES|null: false, foreign_key: true|

### Association
- belongs_to :buyer, foreign_key: :buyer_id, class_name: :User, optional: true
- belongs_to :seller, foreign_key: :seller_id, class_name: :User
- belongs_to :status
- belongs_to :item

---
# Statuses
|Column|Type|Options|
|------|----|-------|
|name|STRING|null: false, unique: true|

### Association
- has_many: deals

---
# sizes
|Column|Type|Options|
|------|----|-------|
|name|STRING|null: false, unique: true|

### Association
- has_many :items
- has_many :size_categories
- has_many :categories, through: :size_categories

---
# size_categories
|Column|Type|Options|
|------|----|-------|
|size_id|REFERENCES|null: false, foreign_key: true|
|category_id|REFERENCES|null: false, foreign_key: true|

### Association
- belongs_to :size, dependent: :destroy
- belongs_to :category, dependent: :destroy

---
# comments
|Column|Type|Options|
|------|----|-------|
|text|TEXT|null: false|
|user_id|REFERENCES|null: false, foreign_key: true|
|item_id|REFERENCES|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item

---
# item_images
|Column|Type|Options|
|------|----|-------|
|image_url|STRING|null: false|
|item_id|REFERENCES|null: false, foreign_key: true|

### Association
- belongs_to :item

---
# categories
|Column|Type|Options|
|------|----|-------|
|name|STRING|null: false, unique: true|
|parent_id|REFERENCES|optional: true, foreign_key, true|

### Association
- has_many :items
- has_many :children, class_name: :Category, foreign_key: :parent_id
- belongs_to :parent, class_name: :Category
- has_many :size_categories
- has_many :sizes, through: :size_categories

---
# brands
|Column|Type|Options|
|------|----|-------|
|name|STRING|null: false, unique: true|

### Association
- has_many :items