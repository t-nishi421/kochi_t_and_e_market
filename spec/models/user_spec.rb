require 'rails_helper'
describe User do

  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録テスト' do
    it "正常な入力値だと有効" do
      expect(@user).to be_valid
    end

    it "ニックネームが未入力だとエラー" do
      @user.nick_name = ""
      @user.valid?
      expect(@user.errors[:nick_name]).to include("を入力してください")
    end

    it "重複したニックネームの場合エラー" do
      @user.save
      user2 = FactoryBot.build(:user)
      user2.valid?
      expect(user2.errors[:nick_name]).to include("はすでに存在します")
    end

    it "メールアドレスが未入力だとエラー" do
      @user.email = ""
      @user.valid?
      expect(@user.errors[:email]).to include("を入力してください")
    end

    it "重複したメールアドレスの場合エラー" do
      @user.save
      user2 = FactoryBot.build(:user)
      user2.valid?
      expect(user2.errors[:email]).to include("はすでに存在します")
    end

    it "パスワードが6文字以下の場合エラー" do
      @user.password = "123456"
      @user.valid?
      expect(@user.errors[:password]).to include("は7文字以上で入力してください")
    end

  end
end