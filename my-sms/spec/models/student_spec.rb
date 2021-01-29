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

  it 'is valid without a gender' do
    expect(FactoryBot.build(:student, gender: nil)).to be_valid
  end
end
