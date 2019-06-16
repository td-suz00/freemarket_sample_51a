require 'rails_helper'

describe ItemsController do
  describe "GET #edit" do

    before do
      brand = create(:brand)
      category= create(:category)
      size = create(:size)
    end

    # インスタンス変数（@item）のテスト
    it "assigns the requested item to @item" do
      item = create(:item)
      get :edit, params:{ id: item }
      expect(assigns(:item)).to eq item

    end

    # ビュー遷移のテスト
    it "renders the :edit template" do
      item = create(:item)
      get :edit, params:{ id: item }
      expect(response).to render_template :edit
    end

  end
end
