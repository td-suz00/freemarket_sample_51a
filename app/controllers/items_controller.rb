class ItemsController < ApplicationController

  def new
    @item = Item.new
    render layout: 'application-off-header-footer.haml'
  end

  def create
  end

  def edit
    render layout: 'application-off-header-footer.haml'
  end

  def update
  end

end
