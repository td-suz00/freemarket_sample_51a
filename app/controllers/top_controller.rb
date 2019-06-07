class TopController < ApplicationController

  def index
    @items = Item.all
  end

end
