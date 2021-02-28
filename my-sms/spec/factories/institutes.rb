# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :institute do
    transient { with_courses { false } }
    sequence(:name) { |n| "Institute #{n}" }
  end
  trait :demo do
    name { [Faker::Educator.university, Faker::Educator.secondary_school].sample }
    courses { with_courses ? Array.new(rand(8)) { association(:course) } : [] }
  end
end
