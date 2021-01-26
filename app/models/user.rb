class User < ApplicationRecord
  validates :name, presence: true
  validates :last_name, presence: true
  has_many :products, dependent: :destroy
end
