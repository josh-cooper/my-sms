# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :course do
    sequence(:name) { |n| "Course #{n}" }
    description 'This is a course description.'
    allocation { rand(1..50) }
    number_of_semesters { rand(1..3) }
    start_date 3.years.ago.to_date
    end_date 2.years.ago.to_date
    institute

    factory :course_demo, class: :course do
      name { Faker::Educator.course_name }
      description { Faker::Lorem.paragraph }
      start_date Faker::Date.between(from: '2014-01-1', to: '2014-06-15')
      end_date Faker::Date.between(from: '2014-06-16', to: '2014-12-30')
      institute { association :institute_demo }
    end
  end
end
