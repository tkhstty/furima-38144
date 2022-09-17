FactoryBot.define do
  factory :user do
    nickname {Faker::Internet.username}
    email {Faker::Internet.free_email}
    password {Faker::Internet.password(min_length: 6, mix_case: true)}
    password_confirmation {password}
    last_name {"佐藤"}
    first_name {"太郎"}
    last_name_reading {"サトウ"}
    first_name_reading {"タロウ"}
    birth_date {Faker::Date.between(from: '1930-01-01', to: '2017-12-31')}
  end
end
