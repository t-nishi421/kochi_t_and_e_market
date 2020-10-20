FactoryBot.define do
  factory :favorite_item do
    association :user, factory: :user
    association :item, factory: :item
  end
end
