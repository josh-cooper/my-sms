# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :institute do
    sequence(:name) { |n| "Institute #{n}" }
  end
  trait :demo do
    name { [Faker::Educator.university, Faker::Educator.secondary_school].sample }
  end
end
