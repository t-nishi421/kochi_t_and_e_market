FactoryBot.define do

  factory :user do
    id                    {1}
    nick_name             {"nickname"}
    email                 {"sample@gmail.com"}
    password              {"1234567"}
    password_confirmation {"1234567"}
  end

end