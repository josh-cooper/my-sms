FactoryBot.define do
  factory :title do
    name { %w[Mr Mrs Miss Ms Master].sample }
  end
end
