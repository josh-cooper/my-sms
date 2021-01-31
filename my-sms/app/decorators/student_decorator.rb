# frozen_string_literal: true

class StudentDecorator < Draper::Decorator
  delegate_all

  def full_name
    "#{title + ' ' if title.present?}"\
    "#{first_name} "\
    "#{middle_name + ' ' if middle_name.present?}"\
    "#{last_name}"
  end
end
