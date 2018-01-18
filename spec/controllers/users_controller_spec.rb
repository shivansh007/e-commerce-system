require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context 'GET' do
    it 'should all successfully' do
      get :index, format: :json
      response.should have_http_status(:ok)
    end

    it 'should user successfully' do
      user = create(:user)
      get :show, format: :json, id: user.id
      response.should have_http_status(:ok)
    end

    it 'should user not found' do
      get :show, format: :json, id: 0
      response.should have_http_status(:not_found)
    end

    it 'should user should logout' do
      get :logout
      response.should have_http_status(:found)
    end
  end

  context 'POST' do
    it 'should user successfully' do
      get :new
      response.should have_http_status(:ok)
    end

    it 'should user successfully' do
      user = create(:user)
      get :edit, id: user.id
      response.should have_http_status(:ok)
    end

    it 'should user should login' do
      user = create(:user)
      post :login, user: { email: user.email, password: user.password }
      response.should have_http_status(:found)
    end

    it 'should user should not login' do
      post :login, format: :json, user: { email: '', password: '' }
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should user successfully' do
      get :edit, id: 0
      response.should_not have_http_status(:ok)
    end

    it 'should user successfully' do
      user = create(:user)
      post :create, format: :json, user: { name: user.name, email: user.email, password: user.password, phone: user.phone, address: user.address }
      response.should have_http_status(:ok)
    end

    it 'should user unsuccessfully' do
      post :create, format: :json, user: { name: '', email: '', password: '', phone: '', address: '' }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT' do
    it 'should user successfully' do
      user = create(:user)
      put :update, format: :json, id: user.id, user: { name: user.name, email: user.email, password: user.password, phone: user.phone, address: user.address }
      response.should have_http_status(:ok)
    end

    it 'should user unsuccessfully' do
      user = create(:user)
      put :update, format: :json, id: user.id, user: { name: '', email: '', password: '', phone: '', address: '' }
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should user not found' do
      put :update, format: :json, id: 0
      response.should have_http_status(:not_found)
    end
  end

  context 'DELETE' do
    it 'should user successfully' do
      user = create(:user)
      delete :destroy, format: :json, id: user.id
      response.should have_http_status(:ok)
    end
    it 'should user not found' do
      delete :destroy, format: :json, id: 0
      response.should have_http_status(:not_found)
    end
  end
end
