class CreateTitles < ActiveRecord::Migration
  HONORIFICS = %w[Mr Mrs Miss Ms Master]

  def report_student_titles
    invalid_titles = Student.where("title NOT IN (?)", HONORIFICS)
    invalid_titles.each do |title|
    logger.warn "Unexpected Student title #{s.title} in "\
         "Student id #{s.id}. Migration expects titles "\
         "in Students column to be one of #{HONORIFICS}."
    end
  end

  def up
    # warn of any students with unexpected titles
    report_student_titles

    # create titles table
    create_table :titles do |t|
      t.string :name, null: false

      t.timestamps
    end

    # pre-populate titles with english honorifics
    HONORIFICS.each do |name|
      Title.create({ name: name })
    end
  end

  def down
    # drop titles table
    drop_table :titles
  end
end
