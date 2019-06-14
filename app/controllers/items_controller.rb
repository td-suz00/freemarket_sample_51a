class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :destroy]

  def new
    @item = Item.new
    @item.item_images.build
    render layout: 'application-off-header-footer.haml'
  end

  def create
    # ブランド名がstringでparamsに入ってくるので、id番号に書き換え
    if brand = Brand.find_by(name: params[:item][:brand_id])
      params[:item][:brand_id] = brand.id
    else
      params[:item][:brand_id] = Brand.create(name: params[:item][:brand_id]).id
    end
    @item = Item.new(item_params)
    if params[:item][:item_images_attributes].present? && @item.save
      # 写真２枚目以降があれば保存（１枚目はItem.saveで保存されています）
      if params[:item_images].present?
        params[:item_images][:image].each do |image|
          @item.item_images.create(image_url: image, item_id: @item.id)
        end
      end
      Deal.create(seller_id: current_user.id ,item_id: @item.id, status_id:1)
      redirect_to root_path
    else
      @item.item_images.build
      render action: "new"
    end

  end

  def edit
    render layout: 'application-off-header-footer.haml'
  end

  def show
    render layout: 'application-off-header-footer.haml'
  end

  def update
  end

  def destroy
    if @item.deal.seller == current_user
      @item.destroy
      redirect_to root_path, notice: "削除しました。"
    else
      redirect_to :back, alert: "削除できませんでした。"
    end
  end

  def auto_complete
    brands = Brand.select(:name).where("name like '" + params[:term].tr('ぁ-ん','ァ-ン') + "%'").order(:name)
    brands = brands.pluck(:name)
    render json: brands.to_json
  end

  def search_category
    category = Category.find(params[:parent_id])
    if params[:parent_id].to_i >= 159
      @children = category.sizes
    else
      @children = category.children
    end
   respond_to do |format|
     format.html
     format.json
   end
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :text, :category_id, :size_id, :brand_id, :condition, :delivery_fee_payer, :delivery_type, :delibery_from_area, :delivery_days, :price, item_images_attributes: [:id, :image_url, :item_id])
  end

end
