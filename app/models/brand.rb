class Brand < ApplicationRecord
  has_many :items

  validates :name, presence: true

  # 未登録のブランドを登録する
  def self.saveIfNotPresent(brand)
    unless Brand.exists?(name: brand.to_s)
      Brand.create(name: brand)
    end
  end
end
