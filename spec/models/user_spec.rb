require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validates_presence_of(:name) }
    it { should validates_presence_of(:last_name) }  
    it { should have_many(:products).dependent(:destroy) }
  end  
end