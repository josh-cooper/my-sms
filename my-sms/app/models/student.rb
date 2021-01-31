# frozen_string_literal: true

class Student < ActiveRecord::Base
  attr_accessible :title, :first_name, :middle_name, :last_name, :email,
                  :birth_date, :gender

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP,
                              message: 'Must be a valid email' }
  validates :birth_date, presence: true

  def full_name
    "#{title + ' ' if title.present?}"\
    "#{first_name} "\
    "#{middle_name + ' ' if middle_name.present?}"\
    "#{last_name}"
  end
end
