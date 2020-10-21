class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many :item_images, dependent: :destroy
  accepts_nested_attributes_for :item_images, reject_if: :reject_item_image_blank, allow_destroy: true
  # has_many :purchase_histories
  has_many :comments
  has_many :favorite_items
  belongs_to :user
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_cost
  belongs_to :category
  belongs_to :brand, optional: true
  belongs_to_active_hash :preparation_day
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :trading_status

  def self.search(search)
    if search
      Item.where(['name LIKE (?)', "%#{search}%"])
    else
      Item.all
    end
  end
  
  validates :name, :price, :introduction, :trading_status_id,
            :category, :condition_id, :shipping_cost_id,
            :preparation_day_id, :prefecture_id, presence: true

  validates_associated :item_images
  validates :item_images, presence: {message: "を１枚以上投稿してください"}

  validates :price, inclusion: { in: 300..9999999 , message: "は指定金額内で入力してください"}

  private
  def reject_item_image_blank(attributes)
    if attributes[:_destroy]
      true
    else
      false
    end
  end
end
