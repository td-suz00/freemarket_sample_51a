class Deal < ApplicationRecord
  belongs_to :buyer
  belongs_to :seller
  belongs_to :status
  belongs_to :item
end
