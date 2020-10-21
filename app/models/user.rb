class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nick_name, presence: true, uniqueness: {case_sensitive: true}
  validates :password, confirmation: true

  has_one :profile, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :credit_card, dependent: :destroy
  has_many :destinations, dependent: :destroy
  has_many :favorite_items, dependent: :destroy
  has_many :purchase_histories
  has_many :items

end
