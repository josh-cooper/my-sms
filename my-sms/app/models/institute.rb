# frozen_string_literal: true

class Institute < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true
end
