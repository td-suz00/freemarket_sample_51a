class ItemsController < ApplicationController

  def new
    @item = Item.new
    @item.item_images.build
    render layout: 'application-off-header-footer.haml'
  end

  def create
    @item = Item.create(item_params)
    respond_to do |format|
      if @item.save
        binding.pry
        params[:item_images][:image].each do |image|
          @item.item_images.create(image_url: image, item_id: @item.id)
        end
        format.html{redirect_to root_path}
      else
        @item.item_images.build
        format.html{render action: "new"}
      end
    end
  end

  def edit
    render layout: 'application-off-header-footer.haml'
  end

  def update
  end

  private
  def item_params
    params.require(:item).permit(:name, :text, :category_id, :size_id, :brand_id, :condition, :delivery_fee_payer, :delivery_type, :delibery_from_area, :delivery_days, :price, item_images_attributes: [:id, :image_url, :item_id]).merge(seller_id: 1)
    #### ログイン機能ができたら.merge(seller_id: current_user.id)
  end

end
