# frozen_string_literal: true

class StudentDecorator < Draper::Decorator
  delegate_all

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def full_name
    [title, first_name, middle_name, last_name].select(&:present?).join(' ')
  end
end
