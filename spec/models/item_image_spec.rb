require 'rails_helper'
describe ItemImage do
  before do
    @item = FactoryBot.build(:item_image)
  end

  describe '商品出品時の画像テスト' do

    it "正常な入力値だと有効" do
      expect(@item).to be_valid
    end

    it "画像のurlが未入力だとエラー" do
      @item.src = ""
      @item.valid?
      expect(@item.errors[:src]).to include("を入力してください")
    end
  end
end
