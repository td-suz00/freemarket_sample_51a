class ItemImage < ApplicationRecord
  mount_uploader :image_url, ImagesUploader

  belongs_to :item

end
