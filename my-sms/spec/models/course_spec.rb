# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Course, type: :model do
  subject { course }
  let(:course) { build(:course, course_params) }
  let(:course_params) { {} }

  context 'with valid params' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:number_of_semesters) }
    it { is_expected.to validate_presence_of(:start_date) }
    it { is_expected.to validate_presence_of(:end_date) }
  end

  context 'the end date is not after the start date' do
    let(:course_params) { { start_date: 2.days.ago, end_date: 3.days.ago } }
    it { is_expected.to be_invalid }
  end

  context 'the end date is the same as the start date' do
    let(:course_params) { { start_date: 3.days.ago, end_date: 3.days.ago } }
    it { is_expected.to be_valid }
  end
end
