class ItemImage < ApplicationRecord
  mount_uploader :image_url, ImagesUploader
end
