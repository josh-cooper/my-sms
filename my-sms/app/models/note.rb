# frozen_string_literal: true

class Note < ActiveRecord::Base
  attr_accessible :content, :title

  validates :title, presence: true

  belongs_to :notable, polymorphic: true
end
