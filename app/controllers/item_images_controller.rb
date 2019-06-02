class ItemImagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    @item_image = ItemImage.new
    render layout: 'application-off-header-footer.haml'

  end

  def create
    @item_image = ItemImage.new(file_name: params[:file])
    if @item_image.save
      render json: { message: "success", fileID: @item_image.id }, :status => 200
    else
      render json: { error: @item_image.errors.full_messages.join(',')}, :status => 400
    end
  end
end
