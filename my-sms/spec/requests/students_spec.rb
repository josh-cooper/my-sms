# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Students', type: :request do
  it 'loads students' do
    2.times { FactoryBot.create(:student) }
    get students_path
    expect(response).to have_http_status(:success)
  end

end
