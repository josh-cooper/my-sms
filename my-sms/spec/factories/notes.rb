# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :note do
    sequence(:title) { |n| "Title #{n}" }
    content 'This is the note content.'

    for_student
    trait :for_student do
      association :notable, factory: :student
    end
    trait :for_course do
      association :notable, factory: :course
    end
    trait :for_institute do
      association :notable, factory: :institute
    end
  end

  factory :note_demo, class: :note do
    transient { notable { [Student, Course, Institute].sample } }

    title { Faker::Book.title }
    content { Faker::Lorem.paragraph }
    notable_type { notable.name }
    notable_id { notable.all.sample&.id }
  end
end
