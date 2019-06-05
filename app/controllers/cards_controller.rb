class CardsController < ApplicationController

  require 'payjp'

  def index
  end

  def show
    render layout: 'application-off-header-footer.haml'
  end

  def new
    render layout: 'application-off-header-footer.haml'
    card = Card.where(user_id: 1)
    #### 仮置き user_id: current_user.id
    if card.present?
      redirect_to action: :edit, id: 1
      #### 仮置き id: card.id
    end
  end

  def edit
    card = Card.where(user_id: 1).first
    #### 仮置き user_id: current_user.id
    if card.blank?
      redirect_to action: :new
    else
      Payjp.api_key = Rails.application.credentials.payjp[:test_secret_key]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

  def pay #payjpとCardのデータベース作成を実施
    Payjp.api_key = Rails.application.credentials.payjp[:test_secret_key]
    if card_params.blank?
      redirect_to action: :new, notice: '入力されたカード情報が不正です'
    else
      customer = Payjp::Customer.create(
      description: 'メルカリ',
      email: 'test@gmail.com',
      #### 仮置き current_user.email
      card: params[:payjp_token],
      metadata: {user_id: 1}
      #### 仮置き user_id: current_user.id
      )
      @card = Card.new(user_id: 1, customer_id: customer.id, card_id: customer.default_card)
      #### 仮置き user_id: current_user.id
      if @card.save
        redirect_to action: :index
        #### 仮置き 購入確認、マイページ、新規登録でそれぞれリダイレクト先が違う
      else
        redirect_to action: :pay
      end
    end
  end

  def delete #PayjpとCardデータベースを削除します
    card = Card.where(user_id: 1).first
    #### 仮置き user_id: current_user.id
    if card.present?
      Payjp.api_key = Rails.application.credentials.payjp[:test_secret_key]
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
      card.destroy
    end
      redirect_to action: :index
  end

  private

  def card_params
    params.permit(:payjp_token)
  end

end
