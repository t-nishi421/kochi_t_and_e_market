class CreditCardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_card, only: [:index, :update, :destroy]

  def index
    session["return_path"] = params[:item_id] if params[:item_id]
    if @card
      @card_list = CreditCard.get_list(@card.customer_token)
      @default = CreditCard.get_card(@card.customer_token)
    end
  end
  
  def new
    @card = CreditCard.new
    session["return_path"] = params[:item_id] if params[:item_id]
  end
  
  def create
    # binding.pry
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    if current_user.credit_card.nil?
      customer = Payjp::Customer.create(card: params[:payjp_token]) #顧客作成
      card = current_user.build_credit_card(customer_token: customer.id)
      if card.save
        if session["return_path"].present?
          redirect_to purchase_confirmation_item_path(session["return_path"]), notice: "カードを登録しました"
          session["return_path"].clear
        else
          redirect_to user_credit_cards_path(current_user), notice: "カードを登録しました"
        end
      else
        redirect_to new_credit_cards_path
      end
    else
      customer = Payjp::Customer.retrieve(current_user.credit_card.customer_token) #既存の顧客情報を呼出
      customer.cards.create(card: params[:payjp_token])
      redirect_to user_credit_cards_path(current_user), notice: "カードを追加しました"
    end
  end
  
  def update # デフォルトカードの更新
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    customer = Payjp::Customer.retrieve(current_user.credit_card.customer_token)
    customer.default_card = params[:credit_card][:card]
    if customer.save
      if session["return_path"]
        redirect_to purchase_confirmation_item_path(session["return_path"]), notice: "お支払い方法を変更しました"
        session["return_path"].clear
      else
      redirect_to user_credit_cards_path(current_user), notice: "お支払い方法を変更しました"
      end
    else
      render user_credit_cards_path(current_user), alert: "お支払い方法が変更できませんでした"
    end
  end

  def destroy # カード情報の削除とデフォルトカードの更新
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    customer = Payjp::Customer.retrieve(@card.customer_token)
    card = customer.cards.retrieve(params[:card])
    if card.delete
      customer = Payjp::Customer.retrieve(@card.customer_token)
      if customer.default_card.nil?
         customer.delete
         @card.destroy
         redirect_to user_credit_cards_path(current_user), notice: "カードを削除しました"
      else
         redirect_to user_credit_cards_path(current_user), notice: "カードを削除しました"
      end
    else
      redirect_to user_credit_cards_path(current_user), alert: "カードを削除できませんでした"
    end
  end

  private

  def set_card
    @card = CreditCard.find_by(user_id: params[:user_id])
  end

end
