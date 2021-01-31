# frozen_string_literal: true

require 'rails_helper'

describe StudentDecorator do
  it 'formats a full name with title, first name, middle name, last name' do
    student = FactoryBot.build(
      :student,
      title: 'Mr',
      first_name: 'John',
      middle_name: 'Adam',
      last_name: 'Smith'
    ).decorate
    expect(student.full_name).to eq 'Mr John Adam Smith'
  end

  it 'formats a full name when there is no title or middle name' do
    student = FactoryBot.build(
      :student,
      title: nil,
      first_name: 'John',
      middle_name: nil,
      last_name: 'Smith'
    ).decorate
    expect(student.full_name).to eq 'John Smith'
  end
end
