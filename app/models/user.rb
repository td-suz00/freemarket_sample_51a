class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :buyed_items, foreign_key: :buyer_id, class_name: :Item
  has_many :selling_items, -> { where("buyer_id is NULL") }, foreign_key: :seller_id, class_name: :Item
  has_many :sold_items, -> { where("buyer_id is not NULL") }, foreign_key: :seller_id, class_name: :Item

  validates :nickname, presence: true, exclusion: { in: %w(メルカリ) }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, format: { with: /\A(?=.*?[a-z])[a-z\d]+\z/i }
  validates :password_confirmation, presence: true, length: { minimum: 6 }

end
