FactoryBot.define do
  factory :comment do
    comment {"hogehoge"}
    association :user, factory: :user
    association :item, factory: :item
  end
end
