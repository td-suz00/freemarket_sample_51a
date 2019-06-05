class PurchasesController < ApplicationController

  require 'payjp'
  require 'date'

  def new
    @item = Item.find(4)
    #### 仮置き Item.find(params[:item_id])
    render layout: 'application-off-header-footer.haml'
  end

  def pay
    item = Item.find(4)
    #### 仮置き Item.find(params[:item_id])
    card = Card.where(user_id: 1).first
    #### 仮置き card = Card.where(user_id: current_user.id).first

    Payjp.api_key = Rails.application.credentials.payjp[:test_secret_key]
    charge = Payjp::Charge.create(
    :amount => item.price,
    :customer => card.customer_id,
    :currency => 'jpy',
    )
    deal = Deal.find_by(item_id: item.id)
    deal.charge_id = charge.id
    deal.buyer_id = 1
    #### 仮置き deal.buyer_id = 1
    deal.status_id = 2 # ステータスを取引中に更新
    deal.deal_at = DateTime.now
    deal.save
    redirect_to controller: :users, action: :show, id: 1
    #### 仮置き id: current_user.id
  end

end
