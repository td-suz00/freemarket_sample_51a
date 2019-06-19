class PurchasesController < ApplicationController
  before_action :authenticate_user!

  require 'payjp'
  require 'date'

  def new
    @item = Item.find(params[:item_id])
    @card = current_user.card
    if @card
      Payjp.api_key = Rails.application.credentials.payjp[:test_secret_key]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
    render layout: 'application-off-header-footer.haml'
  end

  def pay
    item = Item.find(params[:item_id])
    card = Card.find_by(user_id: current_user.id)
    deal = Deal.find_by(item_id: item.id)
    if card
      Payjp.api_key = Rails.application.credentials.payjp[:test_secret_key]
      charge = Payjp::Charge.create(
        amount:   item.price,
        customer: card.customer_id,
        currency: 'jpy',
      )
      deal.charge_id = charge.id
      deal.buyer_id = current_user.id
      deal.status_id = 2 # ステータスを取引中に更新
      deal.deal_at = DateTime.now
      deal.save
      flash[:notice] = '商品を購入しました'
      redirect_to controller: :users, action: :show, id: current_user.id
    else
      flash[:alert] = 'カード情報を登録してください'
      redirect_to controller: :purchases, action: :new, item_id: item.id
    end
  end

  def address
    @item = Item.find(params[:item_id])
    render layout: 'application-off-header-footer.haml'
  end

  def card
    @item = Item.find(params[:item_id])
    gon.payjp_test_pk = Rails.application.credentials.payjp[:test_public_key]
    render layout: 'application-off-header-footer.haml'
  end
end
