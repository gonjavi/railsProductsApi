require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  it { should route(:get, '/api/v1/users').to(action: :index) }
  it { should route(:post, '/api/v1/users').to(action: :create) }
  it { should route(:delete, '/api/v1/users/1').to(action: :destroy, id: 1) }
  it { should route(:put, '/api/v1/users/1').to(action: :update, id: 1) }
  it { should route(:get, '/api/v1/users/1').to(action: :show, id: 1) }

  let(:valid_attributes) { { name: 'Javier', last_name: 'Paz' } }
  let(:invalid_attributes) { { name: '', last_name: '' } }

  before :each do
    @user = FactoryBot.create(:user)
  end

  describe 'GET #index users' do
    before { get :index }

    it { should respond_with(200) }
  end

  describe 'POST #create user' do
    it do
      params = {
        user: {
          id: 1,
          params: {
            name: 'Javier',
            las_name: 'Mancilla'
          }
        }
      }
      should permit(:name, :last_name)
        .for(:create, params: params)
        .on(:user)
    end

    it 'creates a new user' do
      expect do
        post :create, params: { user: valid_attributes }
      end.to change(User, :count).by(1)
      expect(response).to have_http_status(200)
    end

    it 'it fails to create a new user' do
      expect do
        post :create, params: { user: invalid_attributes }
      end.to change(User, :count).by(0)
      expect(response).to have_http_status(422)
    end
  end

  describe 'DELETE #destroy' do
    it 'it deletes a user' do
      @user = FactoryBot.create(:user)
      expect do
        delete 'destroy', params: { id: @user.id }
      end.to change(User, :count).by(-1)
      expect(response).to have_http_status(200)
    end

    it 'it fails deletes a user' do
      expect do
        delete 'destroy', params: { id: 2 }
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'PUT #update - a user' do
    it 'updates a user' do
      expect do
        put 'update', params: { id: @user.id, user: { name: 'Peter', last_name: 'Toro' } }
      end.to change(User, :count).by(0)        
      expect(response).to have_http_status(200)
    end

    it 'fails updating a user' do
      expect do
        put 'update', params: { id: @user.id, user: nil }
      end.to change(User, :count).by(0)
      expect { User.new.foo }.to raise_error(NameError)
      expect(response).to have_http_status(400)
    end
  end

  describe 'GET #show - a user' do
    it 'shows a user' do
      expect do
        get 'show', params: { id: @user.id }
      end.to change(User, :count).by(0)        
      expect(response).to have_http_status(200)
    end

    it 'fails showing a user' do
      expect do
        get 'show', params: { id: ''  }
      end.to change(User, :count).by(0)
      expect(response).to have_http_status(400)
    end

    it 'it fails showing a user' do
      expect do
        get 'show', params: { id: 2 }
      end.to raise_error(ActiveRecord::RecordNotFound)
      expect(response).to have_http_status(400)
    end
  end
end