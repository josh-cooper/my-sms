# frozen_string_literal: true

class MoveStudentTitleStrToTitleModel < ActiveRecord::Migration
  def up
    # update students table
    change_table :students do |t|
      t.rename(:title, :title_old)
      t.references :title
    end

    logger.warn 'Run rake db:migrate:migrate_students to convert existing title Strings in title_old column.'
  end

  def down
    # re-create string title column
    change_table :students do |t|
      t.string :title_str
    end

    # undo title model association without assuming title implementation in model
    Student.find_each do |student|
      student.update_attribute(:title_str, Title.find(student[:title_id]).name)
    end

    # remove old title (model) column and rename title_str to title
    remove_column :students, :title_id
    rename_column :students, :title_str, :title
  end
end
