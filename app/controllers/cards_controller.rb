class CardsController < ApplicationController

  require 'payjp'

  def index # カード追加ボタン表示 or カード情報&削除ボタン表示
    @card = Card.find_by(user_id: 1)
    #### 仮置き user_id: current_user.id
    if @card
      Payjp.api_key = Rails.application.credentials.payjp[:test_secret_key]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  def show #### 仮置き ユーザー登録完了のビュー
    render layout: 'application-off-header-footer.haml'
  end

  def new # ユーザー新規登録時のビュー
    gon.payjp_test_pk = Rails.application.credentials.payjp[:test_public_key]
    render layout: 'application-off-header-footer.haml'
  end

  def add # マイページ「支払方法」のビュー
    gon.payjp_test_pk = Rails.application.credentials.payjp[:test_public_key]
  end

  def pay #payjpとCardsテーブルへの登録
    Payjp.api_key = Rails.application.credentials.payjp[:test_secret_key]
    if card_params.blank?
      case card_params[:move_from_action]
        when 'add'
          redirect_to action: :add, notice: '入力されたカード情報が不正です'
        when 'new'
          redirect_to action: :new, notice: '入力されたカード情報が不正です'
      end
    else
      customer = Payjp::Customer.create(
        description: 'メルカリ',
        email: 'test@gmail.com',
        #### 仮置き current_user.email
        card: card_params[:payjp_token],
        metadata: {user_id: 1}
        #### 仮置き user_id: current_user.id
      )
      card = Card.new(user_id: 1, customer_id: customer.id, card_id: customer.default_card)
      #### 仮置き user_id: current_user.id
      if card.save
        case card_params[:move_from_action]
          when 'add'
            redirect_to action: :index
          when 'new'
            redirect_to action: :show, id: 1
        end
      else
        case card_params[:move_from_action]
          when 'add'
            redirect_to action: :add, notice: '入力されたカード情報が不正です'
          when 'new'
            redirect_to action: :new, notice: '入力されたカード情報が不正です'
        end
      end
    end
  end

  def destroy #PayjpとCardデータベースを削除
    card = Card.find_by(user_id: 1)
    #### 仮置き user_id: current_user.id
    if card.present?
      Payjp.api_key = Rails.application.credentials.payjp[:test_secret_key]
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
      card.destroy
      redirect_to action: :index, notice: 'カード情報を削除しました'
      return
    end
    redirect_to action: :index
  end

  private

  def card_params
    params.permit(:payjp_token, :move_from_action)
  end

end
