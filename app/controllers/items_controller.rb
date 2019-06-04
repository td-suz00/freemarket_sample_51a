class ItemsController < ApplicationController

  def new
    @item = Item.new
    @item.item_images.build
    render layout: 'application-off-header-footer.haml'
  end

  def auto_complete
    brands = Brand.select(:name).where("name like '" + params[:term].tr('ぁ-ん','ァ-ン') + "%'").order(:name)
    brands = brands.map(&:name)
    render json: brands.to_json
  end

  def create
    item = Item.create(item_params)
    redirect_to root_path
  end

  def edit
    render layout: 'application-off-header-footer.haml'
  end

  def update
  end

  def search_category

    if params[:parent_id].to_i >=159

      @children=Category.find(params[:parent_id]).sizes
    else
      @children=Category.find(params[:parent_id]).children
    end
   respond_to do |format|
     format.html
     format.json
   end
  end

  private
  def item_params
    params.require(:item).permit(:name, :text, :category_id, :size_id, :brand_id, :condition, :delivery_fee_payer, :delivery_type, :delibery_from_area, :delivery_days, :price, item_images_attributes: [:id, :image_url, :item_id]).merge(seller_id: 1)
    #### ログイン機能ができたら.merge(seller_id: current_user.id)
  end

end
