# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :institute do
    sequence(:name) { |n| "Institute #{n}" }
  end
  factory :institute_demo, class: :institute do
    name { [Faker::Educator.university, Faker::Educator.secondary_school].sample }
  end
end
