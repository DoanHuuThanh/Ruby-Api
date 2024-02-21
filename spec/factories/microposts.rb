# frozen_string_literal: true

FactoryBot.define do
  factory :micropost, class: 'Micropost' do
    content { Faker::Lorem.sentence }
    association :user, factory: :user
  end
end
