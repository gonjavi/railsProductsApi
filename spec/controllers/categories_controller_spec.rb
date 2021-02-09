require 'rails_helper'

RSpec.describe Api::V1::CategoriesController, type: :controller do
  it { should route(:get, '/api/v1/categories').to(action: :index) }
  it { should route(:post, '/api/v1/categories').to(action: :create) }
  it { should route(:delete, '/api/v1/categories/1').to(action: :destroy, id: 1) }
  it { should route(:put, '/api/v1/categories/1').to(action: :update, id: 1) }
  

  describe 'GET #index' do
    before { get :index }

    it { should respond_with(200) }
  end
end 
