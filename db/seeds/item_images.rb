28.times.with_index do |i|
  rand(1..3).times do
    ItemImage.create!(item_id:i+1, image_url: File.open("#{Rails.root}/db/image/image#{rand(1..32)}.jpg"))
  end
end