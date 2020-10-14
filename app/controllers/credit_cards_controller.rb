class CreditCardsController < ApplicationController
  before_action :signed_in

  def index
    @card = CreditCard.find_by(user_id: params[:user_id])
    @card_list = CreditCard.get_list(@card.customer_token) if @card
    @default = CreditCard.get_card(@card.customer_token) if @card
  end
  
  def new
    @card = CreditCard.new
  end
  
  def create
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    if current_user.credit_card.nil?
      customer = Payjp::Customer.create(card: params[:payjp_token]) #顧客作成
      card = current_user.build_credit_card(customer_token: customer.id)
      if card.save
        redirect_to user_credit_cards_path(current_user), notice: "カードを登録しました"
      else
        redirect_to new_credit_cards_path
      end
    else
      customer = Payjp::Customer.retrieve(current_user.credit_card.customer_token) #既存の顧客情報を呼出
      customer.cards.create(card: params[:payjp_token])
      redirect_to user_credit_cards_path(current_user), notice: "カードを追加しました"
    end
    # Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    # if current_user.credit_card.nil?
    #   customer = Payjp::Customer.create(card: params[:payjp_token]) #顧客作成
    #   card = current_user.build_credit_card(customer_token: customer.id, default: customer.default_card)
    #   if card.save
    #     redirect_to user_credit_cards_path(current_user), notice: "カードを登録しました"
    #   else
    #     redirect_to new_credit_cards_path
    #   end
    # else
    #   customer = Payjp::Customer.retrieve(current_user.credit_card.customer_token) #既存の顧客情報を呼出
    #   customer.cards.create(card: params[:payjp_token])
    #   redirect_to user_credit_cards_path(current_user), notice: "カードを追加しました"
    # end
  end
  
  def update # デフォルトカードの更新
    @card = CreditCard.find_by(user_id: params[:user_id])
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    customer = Payjp::Customer.retrieve(current_user.credit_card.customer_token)
    customer.default_card = params[:credit_card][:card]
    if customer.save
      redirect_to user_credit_cards_path(current_user), notice: "お支払い方法を変更しました"
    else
      render user_credit_cards_path(current_user), alert: "お支払い方法が変更できませんでした"
    end

    # if params[:credit_card][:card] == current_user.credit_card.default
      # redirect_to user_credit_cards_path(current_user), alert: "お支払い方法に変更ありません"

    # @card = CreditCard.find_by(user_id: params[:user_id])
    # if params[:credit_card][:card] == current_user.credit_card.default
    #   redirect_to user_credit_cards_path(current_user), alert: "お支払い方法に変更ありません"
    # else
    #   Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    #   customer = Payjp::Customer.retrieve(current_user.credit_card.customer_token)
    #   customer.default_card = params[:credit_card][:card]
    #   customer.save
    #   if @card.update(default: customer.default_card)
    #     redirect_to user_credit_cards_path(current_user), notice: "お支払い方法を変更しました"
    #   else
    #     redirect_to user_credit_cards_path(current_user), alert: "お支払い方法が変更できませんでした"
    #   end
    # end
  end

  def destroy # カード情報の削除とデフォルトカードの更新
    @card = CreditCard.find_by(user_id: params[:user_id])
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    customer = Payjp::Customer.retrieve(@card.customer_token) if @card
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

  def signed_in
    unless user_signed_in?
      redirect_to root_path, alert: "会員登録またはログインしてください"
    end
  end

end
