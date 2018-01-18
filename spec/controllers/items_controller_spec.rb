require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  context 'GET' do
    it 'should all successfully' do
      get :index, format: :json
      response.should have_http_status(:ok)
    end

    it 'should item successfully' do
      item = create(:item)
      get :show, format: :json, id: item.id
      response.should have_http_status(:ok)
    end

    it 'should item not found' do
      get :show, format: :json, id: 0
      response.should have_http_status(:not_found)
    end
  end

  context 'POST' do
    it 'should item successfully' do
      get :new
      response.should have_http_status(:ok)
    end

    it 'should item successfully' do
      item = create(:item)
      get :edit, id: item.id
      response.should have_http_status(:ok)
    end

    it 'should item successfully' do
      get :edit, id: 0
      response.should_not have_http_status(:ok)
    end

    it 'should item successfully' do
      item = create(:item)
      post :create, format: :json, item: { name: item.name, description: item.description, price: item.price, stock: item.stock, brand: item.brand, category_id: item.category_id }
      response.should have_http_status(:ok)
    end

    it 'should item unsuccessfully' do
      post :create, format: :json, item: { name: '', description: '', price: '', stock: '', brand: '', category_id: '' }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT' do
    it 'should item successfully' do
      item = create(:item)
      put :update, format: :json, id: item.id, item: { name: item.name, description: item.description, price: item.price, stock: item.stock, brand: item.brand, category_id: item.category_id }
      response.should have_http_status(:ok)
    end

    it 'should item unsuccessfully' do
      item = create(:item)
      put :update, format: :json, id: item.id, item: { name: '', description: '', price: '', stock: '', brand: '', category_id: '' }
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should item not_found' do
      put :update, format: :json, id: 0
      response.should have_http_status(:not_found)
    end
  end

  context 'DELETE' do
    it 'should item successfully' do
      item = create(:item)
      delete :destroy, format: :json, id: item.id
      response.should have_http_status(:ok)
    end

    it 'should item successfully' do
      delete :destroy, format: :json, id: 0
      response.should have_http_status(:not_found)
    end
  end
end
