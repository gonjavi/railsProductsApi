# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name { 'grande' }
    association :product, product_name: 'crema', seller: 'perez'
  end
end