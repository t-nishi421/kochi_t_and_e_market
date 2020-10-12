class CreditCardsController < ApplicationController

  def index
    @card_list = CreditCard.get_list(current_user.credit_card.customer_token) if current_user.credit_card
    @user = current_user
    @card = CreditCard.find_by(params[:user_id])
  end
  
  def new
    @card = CreditCard.new
  end
  
  def create
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    if current_user.credit_card.nil?
      customer = Payjp::Customer.create(card: params[:payjp_token]) #顧客作成
      card = current_user.build_credit_card(customer_token: customer.id, default: customer.default_card)
      if card.save
        redirect_to user_credit_cards_path(current_user)
      else
        redirect_to new_credit_cards_path
      end
    else
      customer = Payjp::Customer.retrieve(current_user.credit_card.customer_token) #既存の顧客情報を呼出
      customer.cards.create(card: params[:payjp_token])
      redirect_to user_credit_cards_path(current_user)
    end
  end
  
  def update # デフォルトカードの更新
    @card = CreditCard.find_by(params[:user_id])
    if params[:credit_card][:card] == current_user.credit_card.default
      redirect_to user_credit_cards_path(current_user), alert: "お支払い方法に変更ありません"
    else
      Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
      customer = Payjp::Customer.retrieve(current_user.credit_card.customer_token)
      customer.default_card = params[:credit_card][:card]
      customer.save
      if @card.update(default: customer.default_card)
        redirect_to user_credit_cards_path(current_user), notice: "お支払い方法を変更しました"
      else
        redirect_to user_credit_cards_path(current_user), alert: "お支払い方法が変更できませんでした"
      end
    end
  end

  def destroy # カード情報の削除とデフォルトカードの更新
    @card = CreditCard.find_by(params[:user_id])
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    customer = Payjp::Customer.retrieve(current_user.credit_card.customer_token)
    card = customer.cards.retrieve(params[:card])
    if card.delete
      customer = Payjp::Customer.retrieve(current_user.credit_card.customer_token)
      @card.update(default: customer.default_card)
      redirect_to user_credit_cards_path(current_user), notice: "カードを削除しました"
    else
      redirect_to user_credit_cards_path(current_user), alert: "カードを削除できませんでした"
    end
  end

end
