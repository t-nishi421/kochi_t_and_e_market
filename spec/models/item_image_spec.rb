require 'rails_helper'
describe ItemImage do
  before do
    @item = FactoryBot.build(:item_image)
    # @item.item_images.new(FactoryBot.build(:item_image))
  end

  describe '商品出品時の画像テスト' do

    # 通ってないテスト
    it "正常な入力値だと有効" do
      expect(@item).to be_valid
    end

    # 通ってないテスト
    it "画像のurlが未入力だとエラー" do
      @item.src = ""
      @item.valid?
      expect(@item.errors[:src]).to include("を入力してください")
    end
  end
end
