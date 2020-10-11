FactoryBot.define do
  
  factory :destination do
    family_name      {"姓"}
    first_name       {"名"}
    family_name_kana {"セイ"}
    first_name_kana  {"メイ"}
    postal_code      {"1234567"}
    prefecture       {Prefecture.find_by_id(1)}
    city             {"一ツ橋町"}
    house_number     {"1丁目"}
    building_name    {""}
    telephone        {""}
  end

end