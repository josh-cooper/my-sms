# frozen_string_literal: true

class Note < ActiveRecord::Base
  attr_accessible :content, :title

  belongs_to :notable, polymorphic: true
end
