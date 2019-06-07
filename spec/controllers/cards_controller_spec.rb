require 'rails_helper'

RSpec.describe CardsController, type: :controller do

  describe "GET #index" do
    it "renders the :index template" do
      get :index, params: { user_id: 1 }
      expect(response).to render_template :index
    end

    it "assigns the requested card to @card" do
      card = Card.find_by(user_id: 1)
      get :index, params: { user_id: 1 }
      expect(assigns(:card)).to eq card
    end
  end

  describe "GET #new" do
    it "renders the :new template" do
      get :new, params: { user_id: 1 }
      expect(response).to render_template :new
    end
  end

  describe "GET #add" do
    it "renders the :add template" do
      get :add, params: { user_id: 1 }
      expect(response).to render_template :add
    end
  end

  describe "GET #show" do
    it "renders the :show template" do
      get :show, params: { user_id: 1, id: 1 }
      expect(response).to render_template :show
    end
  end

  describe "POST #pay" do
    context "move from cards#add" do
      context "can save" do
        it "redirect to cards#index" do
          # カードトークン生成できないためテスト不可
        end
      end

      context "can not save" do
        it "redirect to cards#add" do
          card = create(:card)
          post :pay, params: { user_id: 1, move_from_action: "add"}
          expect(response).to redirect_to action: :add, notice: "入力されたカード情報が不正です"
        end
      end
    end

    context "move from cards#new" do
      context "can save" do
        it "redirect to cards#show" do
          # カードトークン生成できないためテスト不可
        end
      end

      context "can not save" do
        it "redirect to cards#new" do
          card = create(:card)
          post :pay, params: { user_id: 1, move_from_action: "new"}
          expect(response).to redirect_to action: :new, notice: "入力されたカード情報が不正です"
        end
      end
    end
  end
end
