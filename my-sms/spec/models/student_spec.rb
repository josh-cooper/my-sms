# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Student, type: :model do
  subject { student }
  let(:student) { build(:student, student_params) }
  let(:other_student) { build(:student) }
  let(:student_params) { {} }

  context 'with valid params' do
    it 'has a valid factory' do
      should be_valid
    end

    it 'has a factory that generates unique emails' do
      should_not eq other_student.email
    end
  end

  context 'with invalid params' do
    it { should validate_presence_of(:first_name) }

    it { should validate_presence_of(:last_name) }

    it { should validate_presence_of(:email) }

    it { should validate_presence_of(:birth_date) }

    it { should_not validate_presence_of(:title) }

    it { should_not validate_presence_of(:gender) }

    it { should_not validate_presence_of(:middle_name) }

    it {
      should_not allow_value('invalid').for(:email)
      should_not allow_value('invalid.com').for(:email)
      should_not allow_value('invalid@').for(:email)
    }
  end

  context 'a student with the same email exists' do
    let(:student) { build(:student, email: 'user@example.com') }
    let(:other_student) { create(:student, email: 'user@example.com') }

    before { other_student }

    it 'is invalid with a duplicate email address' do
      should be_invalid
    end
  end
end
