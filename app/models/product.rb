class Product < ApplicationRecord
  validates :product_name, presence: true
  validates :seller, presence: true
  has_many :categories, dependent: :destroy
  belongs_to :user
end
