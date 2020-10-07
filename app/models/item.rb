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

end
