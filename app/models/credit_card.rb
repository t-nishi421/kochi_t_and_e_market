class CreditCard < ApplicationRecord

  belongs_to :user
  
  def self.get_card(customer_token)
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    customer = Payjp::Customer.retrieve(customer_token)
    card = customer.cards.retrieve(customer.default_card)
  end
  
  def self.get_list(customer_token)
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    customer = Payjp::Customer.retrieve(customer_token)
    cards = customer.cards.all(limit: 5)
  end

end
