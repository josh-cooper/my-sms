class CreateTitles < ActiveRecord::Migration
  def up
    available_titles = %w[Mr Mrs Miss Ms Master]

    # do not perform migration if any unexpected titles found in Students
    # may be more efficient to do via SQL query?
    Student.find_in_batches do |batch|
      batch.uniq{|s| s[:title]}.each do |s|
        if available_titles.exclude? s.title
          raise "Unexpected Student title #{s.title} in "\
          "Student id #{s.id}. Migration expects titles "\
          "in Students column to be one of #{available_titles}."
        end
      end
    end

    # create titles table
    create_table :titles do |t|
      t.string :name

      t.timestamps
    end

    # pre-populate titles with english honorifics
    available_titles.each do |name|
      Title.create({ name: name })
    end

    # cache titles from db to avoid multiple queries
    title_name_to_id = {}
    Title.all.each do |title|
      title_name_to_id[title.name] = title.id
    end

    # update students table
    change_table :students do |t|
      t.references :title
    end

    # add title model association
    # without making assumptions about model
    Student.reset_column_information
    Student.find_each do |student|
      student.update_attribute(:title_id, title_name_to_id.fetch(student.title, nil))
      student.save
    end

    # remove old title (string) column
    remove_column :students, :title
  end

  def down
    # create temporary title_string column
    add_column :students, :title_string, :string

    # undo title model association without assuming title implementation in model
    Student.find_each do |student|
      student.update_attribute(:title_string, Title.find(student.title_id).name)
    end

    # remove title (model) column and rename title_string to title
    change_table :students do |t|
      t.remove :title_id
      t.rename :title_string, :title 
    end

    # drop titles table
    drop_table :titles
  end
end
