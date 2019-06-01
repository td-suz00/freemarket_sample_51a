class ItemsController < ApplicationController

  def new
    render :layout => 'application-off-header-footer.haml'
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
