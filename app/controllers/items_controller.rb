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
      new_image_params[:images].each do |image|
        @item.item_images.create(image_url: image, item_id: @item.id)
      end
      Deal.create(seller_id: 1, item_id: @item.id, status_id: 1)
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
    gon.item = @item
    gon.item_images = @item.item_images

    # @item.item_imagse.image_urlをバイナリーデータにしてビューで表示できるようにする
    require 'base64'
    gon.item_images_binary_datas = []
    @item.item_images.each do |image|
      binary_data = File.read(image.image_url.file.file)
      gon.item_images_binary_datas << Base64.strict_encode64(binary_data)
    end
  end

  def update
    # ブランド名がstringでparamsに入ってくるので、id番号に書き換え
    if  brand = Brand.find_by(name: params[:item][:brand_id])
      params[:item][:brand_id] = brand.id
    else
      params[:item][:brand_id] = Brand.create(name: params[:item][:brand_id]).id
    end

    @item = Item.find(params[:id])
    @item.update(item_params)
    binding.pry

    # 登録済画像のidの配列を生成
    ids = @item.item_images.map{|image| image.id }
    # 消されずにまだ残っている画像のidの配列を生成
    exist_ids = registered_image_params[:ids].map(&:to_i)

    unless ids.length == exist_ids.length
      # 削除する画像のidの配列を生成
      delete_ids = ids - exist_ids
      # 登録済画像のうち削除ボタンをおした画像を削除
      delete_ids.each do |id|
        @item.item_images.find(id).destroy
      end
    end

    # 新規登録画像があればcreate
    if new_image_params.present?
      new_image_params[:images].each do |image|
        @item.item_images.create(image_url: image, item_id: @item.id)
      end
    end
    redirect_to root_path
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
  end

  def registered_image_params
    params.require(:registered_images_ids).permit({ids: []})
  end

  def new_image_params
    params.require(:new_images).permit({images: []})
  end

end
