# frozen_string_literal: true

class CourseDecorator < Draper::Decorator
  delegate_all
  decorates_association :institute

  def self.collection_decorator_class
    PaginatingDecorator
  end
end
