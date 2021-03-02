# frozen_string_literal: true

class AddIndexToNotes < ActiveRecord::Migration
  def change
    add_index(:notes, %i[notable_id notable_type])
  end
end
