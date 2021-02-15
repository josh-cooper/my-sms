class MoveStudentTitleStrToTitleModel < ActiveRecord::Migration
  def up
    # update students table
    change_table :students do |t|
      t.rename(:title, :title_old)
      t.references :title
    end

    # add title model association
    # without making assumptions about model
    # add any titles not already in the db
    Student.reset_column_information
    Student.find_each do |student|
      title = Title.where(name: student[:title_old]).first_or_create
      student.update_attribute(:title_id, title.id)
      student.save
    end

    # remove old title (string) column
    remove_column :students, :title_old
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
