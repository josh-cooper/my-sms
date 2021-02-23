# frozen_string_literal: true

class Institute < ActiveRecord::Base
  attr_accessible :name, :courses

  has_many :courses
  has_many :notes, as: :notable

  validates :name, presence: true

  DEFAULT_PER_PAGE = 10
end
