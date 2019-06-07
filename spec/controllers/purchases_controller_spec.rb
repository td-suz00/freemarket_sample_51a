require 'rails_helper'
require 'date'

RSpec.describe PurchasesController, type: :controller do

  describe "GET #new" do
    it "renders the :new template" do
      get :new, params: { item_id: 1 }
      expect(response).to render_template :new
    end

    it "assigns the requested item to @item" do
      item = Item.find(4)
      get :new, params: { item_id: 4 }
      expect(assigns(:item)).to eq item
    end
  end

  describe "POST #pay" do
    let(:deal) { create(:deal) }
    let(:params) { { item_id: deal.item_id, charge_id: "ch_123456789", buyer_id: 1, status_id: 2, deal_at: DateTime.now } }

    it "redirect to users#show" do
      post :pay, params: params
      expect(response).to redirect_to controller: :users, action: :show, id: 1
    end

    it "update charge_id" do
      post :pay, params: params
      deal.reload
      expect(deal.charge_id).not_to eq params[:charge_id]
    end

    it "update buyer_id" do
      post :pay, params: params
      deal.reload
      expect(deal.buyer_id).not_to eq params[:buyer_id]
    end

    it "update status_id" do
      post :pay, params: params
      deal.reload
      expect(deal.status_id).not_to eq params[:status_id]
    end

    it "update deal_at" do
      post :pay, params: params
      deal.reload
      expect(deal.deal_at).not_to eq params[:deal_at]
    end
  end

end
