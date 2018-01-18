require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  context 'GET' do
    it 'should all successfully' do
      get :index, format: :json
      response.should have_http_status(:ok)
    end

    it 'should category successfully' do
      category = create(:category)
      get :show, format: :json, id: category.id
      response.should have_http_status(:ok)
    end

    it 'should category not found' do
      get :show, format: :json, id: 0
      response.should have_http_status(:not_found)
    end
  end

  context 'POST' do
    it 'should category successfully' do
      get :new
      response.should have_http_status(:ok)
    end

    it 'should category successfully' do
      category = create(:category)
      get :edit, id: category.id
      response.should have_http_status(:ok)
    end

    it 'should category not found' do
      get :edit, id: 0
      response.should_not have_http_status(:ok)
    end

    it 'should category successfully' do
      category = create(:category)
      post :create, format: :json, category: { name: category.name }
      response.should have_http_status(:ok)
    end

    it 'should category unsuccessfully' do
      post :create, format: :json, category: { name: '' }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT' do
    it 'should category successfully' do
      category = create(:category)
      put :update, format: :json, id: category.id, category: { name: category.name }
      response.should have_http_status(:ok)
    end

    it 'should category unsuccessfully' do
      category = create(:category)
      put :update, format: :json, id: category.id, category: { name: '' }
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should category not found' do
      put :update, format: :json, id: 0
      response.should have_http_status(:not_found)
    end
  end

  context 'DELETE' do
    it 'should category successfully' do
      category = create(:category)
      delete :destroy, format: :json, id: category.id
      response.should have_http_status(:ok)
    end

    it 'should category not found' do
      delete :destroy, format: :json, id: 0
      response.should have_http_status(:not_found)
    end
  end
end
