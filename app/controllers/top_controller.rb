class TopController < ApplicationController

  def index
    @redies_items = Item.choose_items(1)
    @mens_items = Item.choose_items(2)
    @baby_kids_items = Item.choose_items(3)
    @beauty_items = Item.choose_items(7)
  end

end
