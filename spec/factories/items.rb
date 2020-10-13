FactoryBot.define do

  factory :item do
    name            {"商品名"}
    price           {"5000"}
    introduction    {"商品説明"}
    trading_status  {"出品中"}
    association :category, factory: :category
    association :brand, factory: :brand
    condition       {Condition.find_by_id(1)}
    shipping_cost   {ShippingCost.find_by_id(1)}
    preparation_day {PreparationDay.find_by_id(1)}
    prefecture      {Prefecture.find_by_id(1)}
    association :user, factory: :user
  end
end
