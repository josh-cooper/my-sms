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

  it 'is invalid without a first name' do
    user = FactoryBot.build(:student, first_name: nil)
    user.valid?
    expect(user.errors[:first_name]).to include('can\'t be blank')
  end
end
