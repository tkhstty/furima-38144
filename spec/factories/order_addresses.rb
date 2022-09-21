FactoryBot.define do
  factory :order_address do
    postal_code { '123-4567' }
    prefecture_id { rand(1..47) }
    city { '横浜市緑区' }
    house_number { '青山1-1-1' }
    building_name { '柳ビル103' }
    phone_number { '09012345678' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
