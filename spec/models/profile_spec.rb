require 'rails_helper'
describe Profile do
  describe '新規登録テスト' do
    it "正常な入力値だと有効" do
      profile = FactoryBot.build(:profile)
      profile.valid?
      expect(profile).to be_valid
    end

    it "姓（全角）が未入力だとエラー" do
      profile = FactoryBot.build(:profile, family_name: "")
      profile.valid?
      expect(profile.errors[:family_name]).to include("を入力してください")
    end

    it "姓（全角）が半角だとエラー" do
      profile = FactoryBot.build(:profile, family_name: "sei")
      profile.valid?
      expect(profile.errors[:family_name]).to include("は全角で入力して下さい")
    end

    it "名（全角）が未入力だとエラー" do
      profile = FactoryBot.build(:profile, first_name: "")
      profile.valid?
      expect(profile.errors[:first_name]).to include("を入力してください")
    end

    it "名（全角）が半角だとエラー" do
      profile = FactoryBot.build(:profile, first_name: "mei")
      profile.valid?
      expect(profile.errors[:first_name]).to include("は全角で入力して下さい")
    end

    it "姓（全角カナ）が未入力だとエラー" do
      profile = FactoryBot.build(:profile, family_name_kana: "")
      profile.valid?
      expect(profile.errors[:family_name_kana]).to include("を入力してください")
    end

    it "姓（全角カナ）が全角ひらがなだとエラー" do
      profile = FactoryBot.build(:profile, family_name_kana: "せい")
      profile.valid?
      expect(profile.errors[:family_name_kana]).to include("は全角カタカナのみで入力して下さい")
    end

    it "姓（全角カナ）が漢字だとエラー" do
      profile = FactoryBot.build(:profile, family_name_kana: "姓")
      profile.valid?
      expect(profile.errors[:family_name_kana]).to include("は全角カタカナのみで入力して下さい")
    end

    it "名（全角カナ）が未入力だとエラー" do
      profile = FactoryBot.build(:profile, first_name_kana: "")
      profile.valid?
      expect(profile.errors[:first_name_kana]).to include("を入力してください")
    end

    it "名（全角カナ）が漢字だとエラー" do
      profile = FactoryBot.build(:profile, first_name_kana: "名")
      profile.valid?
      expect(profile.errors[:first_name_kana]).to include("は全角カタカナのみで入力して下さい")
    end

  end
end