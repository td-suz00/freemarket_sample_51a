class ItemsController < ApplicationController

  def new
    @item = Item.new
  end

  def create
  end

  def edit
    render :layout => 'application-off-header-footer.haml'
  end

  def update
  end

end
