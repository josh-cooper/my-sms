# frozen_string_literal: true

class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :title
      t.string :content
      t.references :notable, polymorphic: true

      t.timestamps
    end
  end
end
