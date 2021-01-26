require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validations' do
    it { should validates_presence_of(:name) }
    it { should belong_to(:product).class_name('Product') }
  end
end

