require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    it { should validates_presence_of(:product_name) }
    it { should validates_presence_of(:seller) }
    it { should belong_to(:user).class_name('User') }
    it { should have_many(:categories).dependent(:destroy) }
  end
end
