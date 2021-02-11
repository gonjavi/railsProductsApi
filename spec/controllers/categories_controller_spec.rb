require 'rails_helper'

RSpec.describe Api::V1::CategoriesController, type: :controller do
  it { should route(:get, '/api/v1/categories').to(action: :index) }
  it { should route(:post, '/api/v1/categories').to(action: :create) }
  it { should route(:delete, '/api/v1/categories/1').to(action: :destroy, id: 1) }
  it { should route(:put, '/api/v1/categories/1').to(action: :update, id: 1) }
  
  let(:user) { User.create({ name: 'Jose', last_name: ' paz' }) }
  let(:product) { Product.create({ product_name: 'crema', seller: ' paz', user_id: user.id }) }
  let(:valid_attributes) { { name: 'nueva', product_id: product.id } }
  let(:invalid_attributes_wrong_id) { { name: 'des', product_id: 5 } }
  let(:invalid_attributes) { { name: '', product_id: nil } }

  before :each do
    @category = FactoryBot.create(:category)
  end

  describe 'GET #index' do
    before { get :index }

    it { should respond_with(200) }
  end

  describe 'POST #create a category' do
    it do
      params = {
        category: {
          id: 1,
          params: {
            name: 'grande',
            product_id: 1
          }        
        }
      }
      should permit(:name, :product_id)
        .for(:create, params: params)
        .on(:category)
    end

    it 'creates a new category' do
      expect do
        post :create, params: { category: valid_attributes }
      end.to change(Category, :count).by(1)
      expect(response).to have_http_status(200)
    end

    it 'it fails to create a new category' do
      expect do
        post :create, params: { category: invalid_attributes }
      end.to change(Category, :count).by(0)
      expect(response).to have_http_status(422)
    end

    it 'it fails to create a new category with id that does not exist' do
      expect do
       post :create, params: { category: invalid_attributes_wrong_id }
     end.to change(Category, :count).by(0)
     expect(response).to have_http_status(422)
    end
  end

  describe 'DELETE #destroy' do
    it 'it deletes a category' do
      expect do
        delete 'destroy', params: { id: @category.id }
      end.to change(Category, :count).by(-1)
      expect(response).to have_http_status(200)
    end

    it 'it fails deletes a category' do
      expect do
        delete 'destroy', params: { id: 2 }
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'PUT #update - a category' do
    it 'updates a category' do
      expect do
        put 'update', params: { id: @category.id, category: { name: 'Grande', product_id: 2 } }
      end.to change(Category, :count).by(0)        
      expect(response).to have_http_status(204)
    end

    it 'fails updating a category' do
      expect do
        put 'update', params: { id: @category.id, category: { name: '', product_id: nil } }
      end.to change(Category, :count).by(0)            
    end
  end
end 
