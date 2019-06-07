class Card < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true, uniqueness: true
  validates :card_id, presence: true, uniqueness: true
  validates :customer_id, presence: true, uniqueness: true
end
