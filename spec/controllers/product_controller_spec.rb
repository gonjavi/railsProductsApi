=begin require 'rails_helper'

RSpec.describe Api::V1::ProductController, type: :controller do
  it { should route(:get, '/api/v1/products').to(action: :index) }

  describe 'GET #index' do
    before { get :index }

    it { should respond_with(200) }
  end
end
 =end