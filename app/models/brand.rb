class Brand < ApplicationRecord
  has_many :items

  validates :name, presence: true

  # 未登録のブランドを登録する
  def self.saveIfNotPresent(brand)
    if Brand.find_by_id(brand.id) == nil
      brand.save
    end
  end
end
