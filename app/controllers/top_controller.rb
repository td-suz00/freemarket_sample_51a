class TopController < ApplicationController

  def index
    @ladies_items = Item.pickup_category_items(1)
    @mens_items = Item.pickup_category_items(2)
    @baby_kids_items = Item.pickup_category_items(3)
    @beauty_items = Item.pickup_category_items(7)
    @chanel_items = Item.pickup_brand_items("シャネル")
    @vuitton_items = Item.pickup_brand_items("ルイ ヴィトン")
    @supreme_items = Item.pickup_brand_items("シュプリーム")
    @nike_items = Item.pickup_brand_items("ナイキ")
  end

end
