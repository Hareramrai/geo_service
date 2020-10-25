# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::FunnyName.unique.name }
    lonlat { "POINT(#{Faker::Address.longitude} #{Faker::Address.latitude})" }
    sequence(:user_id) { |id| id }
  end
end
