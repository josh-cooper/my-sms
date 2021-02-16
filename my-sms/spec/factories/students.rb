# frozen_string_literal: true

FactoryBot.define do
  factory :student do
    association :title, strategy: :build
    first_name 'John'
    middle_name 'Alan'
    last_name 'Smith'
    sequence(:email) { |n| "user#{n}@example.com" }
    birth_date 10.years.ago
    gender { ['male', 'female', nil].sample }
  end
  factory :student_demo, class: :student do
    title_id { [nil, *Title.all.map(&:id)].sample }
    first_name { Faker::Name.first_name }
    middle_name { [nil, Faker::Name.middle_name].sample }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.unique.email }
    birth_date { Faker::Date.birthday(min_age: 18, max_age: 65) }
    gender { [nil, Faker::Gender.type].sample }
  end
end
