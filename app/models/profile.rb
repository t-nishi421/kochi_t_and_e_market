class Profile < ApplicationRecord
  belongs_to :user, optional: true

  validates :family_name, presence: true
  validates :first_name, presence: true
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
