require 'rails_helper'

describe FavoriteItem do
  before do
    @favorite_item = FactoryBot.build(:favorite_item)
  end

  describe 'お気に入り機能のテスト' do

    describe 'whetherBookmarkedメソッドのテスト' do

      it "お気に入り登録されていない場合falseを返す" do
        expect(FavoriteItem.whetherBookmarked(@favorite_item.user_id, @favorite_item.item_id)).to eq(false)
      end
  
      it "既にお気に入り済みの場合trueを返す" do
        @favorite_item.save
        expect(FavoriteItem.whetherBookmarked(@favorite_item.user_id, @favorite_item.item_id)).to eq(true)
      end
    end
  end
end
