class SizeCategory < ApplicationRecord
  belongs_to :size, dependent: :destroy
  belongs_to :category, dependent: :destroy

end
