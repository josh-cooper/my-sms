# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :institute do
    transient { with_courses { false } }
    sequence(:name) { |n| "Institute #{n}" }
    courses { with_courses ? Array.new(rand(8)) { association(:course, with_institute: false) } : [] }
    trait :demo do
      name { [Faker::Educator.university, Faker::Educator.secondary_school].sample }
      courses { with_courses ? Array.new(rand(8)) { association(:course, :demo, with_institute: false) } : [] }
    end
  end
end
