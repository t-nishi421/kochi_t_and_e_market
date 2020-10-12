class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many :item_images
  accepts_nested_attributes_for :item_images, allow_destroy: true
  # has_many :purchase_histories
  belongs_to :user
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_cost
  belongs_to :category
  belongs_to :brand
  belongs_to_active_hash :preparation_day
  belongs_to_active_hash :prefecture

  validates :name, :price, :introduction, :trading_status,
            :category, :condition_id, :shipping_cost_id,
            :preparation_day_id, :prefecture_id, presence: true

  validates :price, inclusion: { in: 300..9999999 , message: "は指定金額内で入力してください"}
end
