FactoryBot.define do

  factory :item_image do
    src  {"sample.png"}
    item {Item.find_by_id(1)}
  end
end
