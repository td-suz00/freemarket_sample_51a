class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile

  has_one :card

  has_many :buyed_deals, foreign_key: :buyer_id, class_name: :Deal
  has_many :selling_deals, -> { where("buyer_id is NULL") }, foreign_key: :seller_id, class_name: :Deal
  has_many :sold_deals, -> { where("buyer_id is not NULL") }, foreign_key: :seller_id, class_name: :Deal

  has_many :buyed_items, through: :buyed_deals, source: :item
  has_many :selling_items, through: :selling_deals, source: :item
  has_many :sold_items, through: :sold_deals, source: :item

  validates :nickname, presence: true, exclusion: { in: %w(メルカリ) }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, format: { with: /\A(?=.*?[a-z])[a-z\d]+\z/i }
  validates :password_confirmation, presence: true, length: { minimum: 6 }

    def self.profile_nested_with_user_is_valid?(params)
       params[:user][:profile_attributes][:family_name].present?\
       &&params[:user][:profile_attributes][:last_name].present?\
       &&params[:user][:profile_attributes][:kana_family_name].present?\
       &&params[:user][:profile_attributes][:kana_last_name].present?\
       &&params[:user][:profile_attributes][:'birth_ymd(1i)'].present?\
       &&params[:user][:profile_attributes][:'birth_ymd(2i)'].present?\
       &&params[:user][:profile_attributes][:'birth_ymd(3i)'].present?
  end
end
