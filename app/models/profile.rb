class Profile < ApplicationRecord
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
    message: "は全角カタカナのみで入力して下さい"
  }
  validates :first_name_kana, presence: true,
    format: {
      with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/,
      message: "は全角カタカナのみで入力して下さい"
    }
  # validates :birthday

end
