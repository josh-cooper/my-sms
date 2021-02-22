# frozen_string_literal: true

class Course < ActiveRecord::Base
  attr_accessible :institute_id, :allocation, :description, :end_date, :name, :number_of_semesters, :start_date

  belongs_to :institute

  validates :name, presence: true
  validates :number_of_semesters, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates_associated :institute

  validate :end_date_after_start

  def end_date_after_start
    return if end_date.blank? || start_date.blank?

    unless end_date >= start_date
      errors.add(:end_date, 'must be after start date')
    end
  end
end
