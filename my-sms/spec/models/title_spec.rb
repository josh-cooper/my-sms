# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Title, type: :model do
  subject { title }
  let(:title) { build(:title, title_params) }
  let(:title_params) { {} }

  context 'with valid params' do
    it { should validate_presence_of(:name) }
  end

  context 'a title with the same name exists' do
    let(:title) { build(:title, name: 'honorific') }
    let!(:other_title) { create(:title, name: 'honorific') }

    before { other_title }

    it 'is is invalid with a duplicate name' do
      is_expected.to be_invalid
    end
  end
end
