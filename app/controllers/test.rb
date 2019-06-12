require 'base64'
binary_data = File.read("../../public/uploads/item_image/image_url/2/image5.jpg")
p Base64.strict_encode64(binary_data)
