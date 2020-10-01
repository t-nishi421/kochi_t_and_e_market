require 'rails_helper'
describe Destination do
  describe '新規登録テスト' do
    it "正常な入力値だと有効" do
      destination = FactoryBot.build(:destination)
      destination.valid?
      expect(destination).to be_valid
    end

    it "姓（全角）が未入力だとエラー" do
      destination = FactoryBot.build(:destination, family_name: "")
      destination.valid?
      expect(destination.errors[:family_name]).to include("を入力してください")
    end

    it "姓（全角）が半角だとエラー" do
      destination = FactoryBot.build(:destination, family_name: "sei")
      destination.valid?
      expect(destination.errors[:family_name]).to include("は全角で入力して下さい")
    end

    it "名（全角）が未入力だとエラー" do
      destination = FactoryBot.build(:destination, first_name: "")
      destination.valid?
      expect(destination.errors[:first_name]).to include("を入力してください")
    end

    it "名（全角）が半角だとエラー" do
      destination = FactoryBot.build(:destination, first_name: "mei")
      destination.valid?
      expect(destination.errors[:first_name]).to include("は全角で入力して下さい")
    end

    it "姓（全角カナ）が未入力だとエラー" do
      destination = FactoryBot.build(:destination, family_name_kana: "")
      destination.valid?
      expect(destination.errors[:family_name_kana]).to include("を入力してください")
    end

    it "姓（全角カナ）が全角ひらがなだとエラー" do
      destination = FactoryBot.build(:destination, family_name_kana: "せい")
      destination.valid?
      expect(destination.errors[:family_name_kana]).to include("は全角カタカナで入力して下さい")
    end

    it "姓（全角カナ）が漢字だとエラー" do
      destination = FactoryBot.build(:destination, family_name_kana: "姓")
      destination.valid?
      expect(destination.errors[:family_name_kana]).to include("は全角カタカナで入力して下さい")
    end

    it "名（全角カナ）が未入力だとエラー" do
      destination = FactoryBot.build(:destination, first_name_kana: "")
      destination.valid?
      expect(destination.errors[:first_name_kana]).to include("を入力してください")
    end

    it "名（全角カナ）が全角ひらがなだとエラー" do
      destination = FactoryBot.build(:destination, first_name_kana: "めい")
      destination.valid?
      expect(destination.errors[:first_name_kana]).to include("は全角カタカナで入力して下さい")
    end

    it "名（全角カナ）が漢字だとエラー" do
      destination = FactoryBot.build(:destination, first_name_kana: "名")
      destination.valid?
      expect(destination.errors[:first_name_kana]).to include("は全角カタカナで入力して下さい")
    end

    it "住所が6桁だとエラー" do
      destination = FactoryBot.build(:destination, postal_code: 123456)
      destination.valid?
      expect(destination.errors[:postal_code]).to include("は7文字で入力してください")
    end

    it "住所が8桁だとエラー" do
      destination = FactoryBot.build(:destination, postal_code: 123454678)
      destination.valid?
      expect(destination.errors[:postal_code]).to include("は7文字で入力してください")
    end

    it "住所が文字だとエラー" do
      destination = FactoryBot.build(:destination, postal_code: "一二三四五六七")
      destination.valid?
      expect(destination.errors[:postal_code]).to include("は7文字で入力してください")
    end

    it "都道府県が未入力だとエラー" do
      destination = FactoryBot.build(:destination, prefecture: "")
      destination.valid?
      expect(destination.errors[:prefecture]).to include("を入力してください")
    end

    it "市区町村が未入力だとエラー" do
      destination = FactoryBot.build(:destination, city: "")
      destination.valid?
      expect(destination.errors[:city]).to include("を入力してください")
    end

    it "番地が未入力だとエラー" do
      destination = FactoryBot.build(:destination, house_number: "")
      destination.valid?
      expect(destination.errors[:house_number]).to include("を入力してください")
    end

  end
end