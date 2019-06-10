require 'rails_helper'

describe TopController do

  describe "GET#index" do

    # @ladies_itemsのテスト
    it "assigns the requested ladies_items to @ladies_items" do
      ladies_items = create_list(:item, 4, category_id: 12)
      get :index
      expect(assigns(:ladies_items)).to match(ladies_items)
    end

    # @mens_itemsのテスト
    it "assigns the requested mens_items to @mens_items" do
      mens_items = create_list(:item, 4, category_id: 13)
      get :index
      expect(assigns(:mens_items)).to match(mens_items)
    end

    # @baby_kids_itemsのテスト
    it "assigns the requested baby_kids_items to @baby_kids_items" do
      baby_kids_items = create_list(:item, 4, category_id: 14)
      get :index
      expect(assigns(:baby_kids_items)).to match(baby_kids_items)
    end

    # @beauty_itemsのテスト
    it "assigns the requested beauty_items to @beauty_items" do
      beauty_items = create_list(:item, 4, category_id: 15)
      get :index
      expect(assigns(:beauty_items)).to match(beauty_items)
    end

    # @chanel_itemsのテスト
    it "assigns the requested chanel_items to @chanel_items" do
      chanel_items = create_list(:item, 4, brand_id: 1 )
      get :index
      expect(assigns(:chanel_items)).to match(chanel_items)
    end

    # @vuitton_itemsのテスト
    it "assigns the requested vuitton_items to @vuitton_items" do
      vuitton_items = create_list(:item, 4, brand_id: 2 )
      get :index
      expect(assigns(:vuitton_items)).to match(vuitton_items)
    end

    # @supreme_itemsのテスト
    it "assigns the requested supreme_items to @supreme_items" do
      supreme_items = create_list(:item, 4, brand_id: 3)
      get :index
      expect(assigns(:supreme_items)).to match(supreme_items)
    end

    # @nike_itemsのテスト
    it "assigns the requested nike_items to @nike_items" do
      nike_items = create_list(:item, 4, brand_id: 4)
      get :index
      expect(assigns(:nike_items)).to match(nike_items)
    end

    # ビュー遷移のテスト
    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end

  end

end
