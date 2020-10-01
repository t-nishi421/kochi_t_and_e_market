FactoryBot.define do

  factory :user do
    nickname              {"nickname"}
    email                 {"sample@gmail.com"}
    password              {"password"}
    password_confirmation {"password"}
  end

end