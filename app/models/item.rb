class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  # has_many :item_images
  # has_many :purchase_histories
  belongs_to :user
  belongs_to :condition
  belongs_to :shipping_cost
  belongs_to :category
  belongs_to :brand
  belongs_to :preparation_day
  belongs_to :prefecture

  def self.search(search)
    if search
      Item.where(['name LIKE (?)', "%#{search}%"])
    else
      Item.all
    end
  end

end
