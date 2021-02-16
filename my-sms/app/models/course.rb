# frozen_string_literal: true

class Course < ActiveRecord::Base
  attr_accessible :allocation, :description, :end_date, :name, :number_of_semesters, :start_date

  validates :name, presence: true
  validates :number_of_semesters, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  validate :end_date_after_start

  def end_date_after_start
    return unless !end_date.blank? && !start_date.blank?

    unless end_date >= start_date
      errors.add(:end_date, 'must be after start date')
    end
  end
end
