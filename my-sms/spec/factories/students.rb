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
end
