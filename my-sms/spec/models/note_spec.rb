# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Note, type: :model do
  subject { note }
  let(:note) { build(:note, note_params) }
  let(:note_params) { {} }

  context 'with valid params' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to belong_to(:notable) }
  end
end
