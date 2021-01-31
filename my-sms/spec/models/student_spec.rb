# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Student, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.build(:student)).to be_valid
  end

  it 'has a factory that generates unique emails' do
    student = FactoryBot.build(:student)
    other_student = FactoryBot.build(:student)
    expect(student.email).not_to eq other_student.email
  end

  it 'is invalid with a duplicate email address' do
    FactoryBot.create(:student, email: 'user@example.com')
    student = FactoryBot.build(:student, email: 'user@example.com')
    student.valid?
    expect(student.errors[:email]).to include('has already been taken')
  end

  it 'is invalid without a first name' do
    student = FactoryBot.build(:student, first_name: nil)
    student.valid?
    expect(student.errors[:first_name]).to include('can\'t be blank')
  end

  it 'is invalid without a last name' do
    student = FactoryBot.build(:student, last_name: nil)
    student.valid?
    expect(student.errors[:last_name]).to include('can\'t be blank')
  end

  it 'is invalid without an email' do
    student = FactoryBot.build(:student, email: nil)
    student.valid?
    expect(student.errors[:email]).to include('can\'t be blank')
  end

  it 'is invalid without a birth date' do
    student = FactoryBot.build(:student, birth_date: nil)
    student.valid?
    expect(student.errors[:birth_date]).to include('can\'t be blank')
  end

  it 'is valid without a title' do
    expect(FactoryBot.build(:student, title: nil)).to be_valid
  end

  it 'is valid without a gender' do
    expect(FactoryBot.build(:student, gender: nil)).to be_valid
  end

  it 'is valid without a middle name' do
    expect(FactoryBot.build(:student, middle_name: nil)).to be_valid
  end

  it 'is invalid with an incorrect format' do
    aggregate_failures do
      expect(FactoryBot.build(:student, email: 'invalid')).to_not be_valid
      expect(FactoryBot.build(:student, email: 'invalid.com')).to_not be_valid
      expect(FactoryBot.build(:student, email: 'invalid@')).to_not be_valid
    end
  end

  it 'formats a full name with title, first name, middle name, last name' do
    student = FactoryBot.build(
      :student,
      title: 'Mr',
      first_name: 'John',
      middle_name: 'Adam',
      last_name: 'Smith'
    )
    expect(student.full_name).to eq 'Mr John Adam Smith'
  end

  it 'formats a full name when there is no title or middle name' do
    student = FactoryBot.build(
      :student,
      title: nil,
      first_name: 'John',
      middle_name: nil,
      last_name: 'Smith'
    )
    expect(student.full_name).to eq 'John Smith'
  end
end
