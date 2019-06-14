class SnsCredential < ApplicationRecord
  validates :provider, presence: true
  validates :uid, presence: true
  validates :email, presence: true
end
