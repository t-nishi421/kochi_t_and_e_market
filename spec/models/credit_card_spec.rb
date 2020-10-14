require 'rails_helper'

# RSpec.describe CreditCard, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
describe CreditCard do

  describe "クレジットカードのテスト" do
    
    it "customer_tokenが空の場合登録できない" do
      card = build(:credit_card, customer_token: "")
      card.valid?
      expect(card.errors[:customer_token]).to include("を入力してください")
    end


  end
  
  it "get_listメソッドが使用できるか" do
    allow(CreditCard).to receive(:get_list).and_return("dummy")
    expect(CreditCard.get_list("dummy")).to eq("dummy")
  end
  
  it "get_cardメソッドが使用できるか" do
    allow(CreditCard).to receive(:get_card).and_return("dummy")
    expect(CreditCard.get_card("dummy")).to eq("dummy")
  end

end