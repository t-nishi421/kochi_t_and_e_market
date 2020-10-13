FactoryBot.define do

  factory :item_image do
    src  {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/pictures/test.jpg'))}
    association :item, factory: :item
  end
end
