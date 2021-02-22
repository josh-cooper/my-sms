# frozen_string_literal: true

class AddInstituteToCourses < ActiveRecord::Migration
  def change
    change_table :courses do |t|
      t.references :institute
    end
  end
end
