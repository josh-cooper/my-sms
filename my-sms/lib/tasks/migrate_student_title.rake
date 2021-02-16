# frozen_string_literal: true

namespace :data do
  namespace :migrate do
    # add title model association
    # without making assumptions about model
    # add any titles not already in the db
    desc 'Convert strings in title_old column to title model.'
    task student_titles: :environment do
      if Student.column_names.exclude? 'title_old'
        raise 'Could not find title_old column in students table. Abandoning.'
      end

      Student.find_each do |student|
        title = Title.where(name: student[:title_old]).first_or_create
        student.update_attribute(:title_id, title.id)
        student.save
      end
    end
  end
end
