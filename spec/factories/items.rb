FactoryBot.define do
  factory :item do
    name { Faker::FunnyName.name }
    description { Faker::Lorem.paragraphs }
    category_id { rand(1..10) }
    condition_id { rand(1..6) }
    delivery_charge_id { rand(1..2) }
    prefecture_id { rand(1..47) }
    delivery_duration_id { rand(1..3) }
    price { rand(300..9_999_999) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image1.jpg'), filename: 'test_image1.jpg')
    end
  end
end
