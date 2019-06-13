class ItemsController < ApplicationController

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
    if @item.save
      image_params[:images].each do |image|
        @item.item_images.create(image_url: image, item_id: @item.id)
      end

      Deal.new(seller_id: 1, item_id: @item.id, status_id: 1)
      ####仮置き   正：Deal.create(seller_id:current_user,item_id:@item.id, status_id:1)

      redirect_to root_path

    else
      @item.item_images.build
      render action: "new"
    end

  end

  def show
    set_item
    render layout: 'application-off-header-footer.haml'
  end

  def edit
    @item = Item.find(params[:id])
    # binding.pry
    gon.item = @item

    gon.item_images = @item.item_images

    # @item.item_imagse.image_urlをバイナリーデータにしてビューで表示できるようにする
    require 'base64'
    gon.item_images_binary_datas = []
    @item.item_images.each do |image|
      binary_data = File.read(image.image_url.file.file)
      gon.item_images_binary_datas << Base64.strict_encode64(binary_data)
    end

    # @item.item_images.build

  end

  def update

    # ブランド名がstringでparamsに入ってくるので、id番号に書き換え
    if  brand = Brand.find_by(name: params[:item][:brand_id])
      params[:item][:brand_id] = brand.id
    else
      params[:item][:brand_id] = Brand.create(name: params[:item][:brand_id]).id
    end

    @item = Item.find(params[:id])
    if @item.update(item_params) && image_params[:images].length != 0
      image_params[:images].each do |image|
        item_image = @item.item_images.new(image_url: image, item_id: @item.id)
        item_image.save
      end

      redirect_to root_path
    else
      render action: "edit"
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
    params.require(:item).permit(:name, :text, :category_id, :size_id, :brand_id, :condition, :delivery_fee_payer, :delivery_type, :delibery_from_area, :delivery_days, :price)
    #### ログイン機能ができたら.merge(seller_id: current_user.id)
  end

  # def item_params
  #   params.require(:item).permit(:name, :text, :category_id, :size_id, :brand_id, :condition, :delivery_fee_payer, :delivery_type, :delibery_from_area, :delivery_days, :price, item_images_attributes: [:id, :image_url, :item_id])
  #   #### ログイン機能ができたら.merge(seller_id: current_user.id)
  # end

  def item_edit_params
    params.require(:item).permit(:name, :text, :category_id, :size_id, :brand_id, :condition, :delivery_fee_payer, :delivery_type, :delibery_from_area, :delivery_days, :price)
    #### ログイン機能ができたら.merge(seller_id: current_user.id)
  end

  def image_params
    params.require(:item_images).permit({images: []})
  end



end
