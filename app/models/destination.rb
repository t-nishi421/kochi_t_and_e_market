class Destination < ApplicationRecord
  belongs_to :user, optional: true

  validates :family_name, presence: true,
    format: {
      with: /\A[ぁ-んァ-ン一-龥]/,
      message: "は全角で入力して下さい"
    }
  validates :first_name, presence: true,
    format: {
      with: /\A[ぁ-んァ-ン一-龥]/,
      message: "は全角で入力して下さい"
    }
  validates :family_name_kana, presence: true,
    format: {
      with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/,
      message: "は全角カタカナで入力して下さい"
    }
  validates :first_name_kana, presence: true,
    format: {
      with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/,
      message: "は全角カタカナで入力して下さい"
    }
  validates :postal_code, presence: true, length: { is: 7 }, numericality: :only_integer
  validates :prefecture, presence: true
  validates :city, presence: true
  validates :house_number, presence: true
  validates :telephone, length: { in: 10..11, message: "は10桁または11桁で入力してください" }, numericality: :only_integer
end
