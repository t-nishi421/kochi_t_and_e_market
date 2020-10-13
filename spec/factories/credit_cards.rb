FactoryBot.define do
  factory :credit_card do
    customer_token {"token"}
    default {"card1"}
    association :user, factory: :user
  end
end
