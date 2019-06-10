module TopHelper
  def first_item_image(item)
    item_image = item.item_images.first.image_url
  end
end
