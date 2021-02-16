# frozen_string_literal: true

class Student < ActiveRecord::Base
  attr_accessible :title_id, :first_name, :middle_name, :last_name, :email,
                  :birth_date, :gender
  belongs_to :title

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP,
                              message: 'Must be a valid email' }
  validates :birth_date, presence: true

  DEFAULT_PER_PAGE = 10

  # defer to title name by default
  def title(model = false)
    model ? super : super&.name
  end
end
