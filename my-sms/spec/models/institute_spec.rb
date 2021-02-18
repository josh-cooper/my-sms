require 'rails_helper'

RSpec.describe Institute, :type => :model do
  subject { institute }
  let(:institute) { build(:institute, institute_params) }
  let(:institute_params) { {} }

  context 'with valid params' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
