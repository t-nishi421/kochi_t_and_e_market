require 'rails_helper'

describe Item do

  before do
    @comment = FactoryBot.build(:comment)
  end

  describe 'コメント投稿機能テスト' do
    it "正常な入力値だと有効" do
      expect(@comment).to be_valid
    end

    it "コメントが未入力だとエラー" do
      @comment.comment = ""
      @comment.valid?
      expect(@comment.errors[:comment]).to include("を入力してください")
    end
  end
end
