require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do
  it { should route(:get, '/api/v1/products').to(action: :index) }
  it { should route(:post, '/api/v1/products').to(action: :create) }
  it { should route(:delete, '/api/v1/products/1').to(action: :destroy, id: 1) }
  it { should route(:put, '/api/v1/products/1').to(action: :update, id: 1) }
  it { should route(:get, '/api/v1/products/1').to(action: :show, id: 1) }
  
  let(:user) { User.create({ name: 'Jose', last_name: ' paz' }) }
  let(:valid_attributes) { { product_name: 'desodorante', seller: 'Paz', user_id: user.id } }
  let(:invalid_attributes_wrong_id) { { product_name: 'des', seller: 'Paz', user_id: 5 } }
  let(:invalid_attributes) { { product_name: '', seller: '', user_id: nil } }

  before :each do
    @product = FactoryBot.create(:product)
  end

  describe 'GET #index' do
    before { get :index }

    it { should respond_with(200) }
  end

  describe 'POST #create a product' do
    it do
      params = {
        product: {
          id: 1,
          params: {
            product_name: 'cepillo',
            seller: 'Mancilla',
            user_id: 1
          }        
        }
      }
      should permit(:product_name, :seller)
        .for(:create, params: params)
        .on(:product)
    end

    it 'creates a new product' do
      expect do
        post :create, params: { product: valid_attributes }
      end.to change(Product, :count).by(1)
      expect(response).to have_http_status(200)
    end

    it 'it fails to create a new product' do
      expect do
        post :create, params: { product: invalid_attributes }
      end.to change(Product, :count).by(0)
      expect(response).to have_http_status(422)
    end

    #it 'it fails to create a new product with id that does not exist' do
     # expect do
      #  post :create, params: { product: invalid_attributes_wrong_id }
      #end.to raise_error(ActiveRecord::RecordNotFound)
    #end
  end

  describe 'DELETE #destroy' do
    it 'it deletes a product' do
      @product = FactoryBot.create(:product)
      expect do
        delete 'destroy', params: { id: @product.id }
      end.to change(Product, :count).by(-1)
      expect(response).to have_http_status(200)
    end

    it 'it fails deletes a product' do
      expect do
        delete 'destroy', params: { id: 2 }
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'PUT #update - a product' do
    it 'updates a product' do
      expect do
        put 'update', params: { id: @product.id, product: { product_name: 'Crema', seller: 'colgate', user_id: 2 } }
      end.to change(Product, :count).by(0)        
      expect(response).to have_http_status(204)
    end

    it 'fails updating a product' do
      expect do
        put 'update', params: { id: @product.id, product: { product_name: '', seller: '', user_id: nil } }
      end.to change(Product, :count).by(0)    
        
    end
  end

  describe 'GET #show - a product' do
    it 'shows a product' do
      expect do
        get 'show', params: { id: @product.id }
      end.to change(Product, :count).by(0)        
      expect(response).to have_http_status(200)
    end

    it 'fails showing a product' do
      expect do
        get 'show', params: { id: ''  }
      end.to  raise_error(ActiveRecord::RecordNotFound)
    end

    it 'it fails showing a product' do
      expect do
        get 'show', params: { id: 2 }
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
