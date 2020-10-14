FactoryBot.define do
  factory :credit_card do
    customer_token {"token"}
    association :user, factory: :user
  end
end
