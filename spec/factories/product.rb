# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    product_name { 'desodorante' }
    seller { 'perez' }
    association :user, name: 'james', last_name: 'paz'
  end
end