require 'rails_helper'
describe Item do

  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品テスト' do
    it "正常な入力値だと有効" do
      expect(@item).to be_valid
    end

    it "商品名が未入力だとエラー" do
      @item.name = ""
      @item.valid?
      expect(@item.errors[:name]).to include("を入力してください")
    end

    it "価格が未入力だとエラー" do
      @item.price = ""
      @item.valid?
      expect(@item.errors[:price]).to include("を入力してください")
    end

    it "商品説明が未入力だとエラー" do
      @item.introduction = ""
      @item.valid?
      expect(@item.errors[:introduction]).to include("を入力してください")
    end

    it "カテゴリーが未入力だとエラー" do
      @item.category = nil
      @item.valid?
      expect(@item.errors[:category]).to include("を入力してください")
    end

    it "商品の状態が未入力だとエラー" do
      @item.condition = nil
      @item.valid?
      expect(@item.errors[:condition]).to include("を入力してください")
    end

    it "配送料の負担が未入力だとエラー" do
      @item.shipping_cost = nil
      @item.valid?
      expect(@item.errors[:shipping_cost]).to include("を入力してください")
    end

    it "発送までの日数が未入力だとエラー" do
      @item.preparation_day = nil
      @item.valid?
      expect(@item.errors[:preparation_day]).to include("を入力してください")
    end

    it "配送元の地域が未入力だとエラー" do
      @item.prefecture = nil
      @item.valid?
      expect(@item.errors[:prefecture]).to include("を入力してください")
    end
  end
end
