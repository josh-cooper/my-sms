# frozen_string_literal: true

namespace :data do
  desc 'Generate demo data using FactoryBot.'
  task generate: :environment do
    require 'factory_bot_rails'
    80.times { FactoryBot.create(:student, :demo) }
    30.times { FactoryBot.create(:institute, :demo, with_courses: true) }
  end
end
