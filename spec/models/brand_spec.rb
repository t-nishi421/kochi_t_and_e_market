require 'rails_helper'
describe Brand do
  before do
    @brand = FactoryBot.build(:brand)
  end

  describe '商品出品時のブランド登録テスト' do

    it "登録されていないブランド名だと新規に登録される" do
      expect(Brand.saveIfNotPresent(@brand)).to be_truthy
    end
  end
end
