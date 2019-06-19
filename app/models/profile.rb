class Profile < ApplicationRecord
  belongs_to :user

  validates :phone_number, presence: true, on: :sms_confirmation_send
  with_options presence: true,on: :hoge  do
    validates  :postalcode, :address_prefecture, :address_city, :address_street_number
  end

end
