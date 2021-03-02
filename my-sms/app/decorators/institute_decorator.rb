# frozen_string_literal: true

class InstituteDecorator < Draper::Decorator
  delegate_all

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def to_s
    name
  end
end
