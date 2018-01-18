require 'rails_helper'

RSpec.describe InvoicesController, type: :controller do
  context 'GET' do
    it 'should all successfully' do
      get :index, format: :json
      response.should have_http_status(:ok)
    end

    it 'should invoice successfully' do
      invoice = create(:invoice)
      get :show, format: :json, id: invoice.id
      response.should have_http_status(:ok)
    end

    it 'should invoice not found' do
      get :show, format: :json, id: 0
      response.should have_http_status(:not_found)
    end
  end

  context 'POST' do
    it 'should invoice successfully' do
      get :new
      response.should have_http_status(:ok)
    end

    it 'should invoice successfully' do
      invoice = create(:invoice)
      get :edit, id: invoice.id
      response.should have_http_status(:ok)
    end

    it 'should invoice successfully' do
      get :edit, id: 0
      response.should_not have_http_status(:ok)
    end

    it 'should invoice successfully' do
      invoice = create(:invoice)
      post :create, format: :json, invoice: { order_id: invoice.order_id }
      response.should have_http_status(:ok)
    end

    it 'should invoice unsuccessfully' do
      post :create, format: :json, invoice: { order_id: '' }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT' do
    it 'should invoice successfully' do
      invoice = create(:invoice)
      put :update, format: :json, id: invoice.id, invoice: { order_id: invoice.order_id }
      response.should have_http_status(:ok)
    end

    it 'should invoice unsuccessfully' do
      invoice = create(:invoice)
      put :update, format: :json, id: invoice.id, invoice: { order_id: '' }
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should invoice not found' do
      put :update, format: :json, id: 0, invoice: { order_id: '' }
      response.should have_http_status(:not_found)
    end
  end

  context 'DELETE' do
    it 'should invoice successfully' do
      invoice = create(:invoice)
      delete :destroy, format: :json, id: invoice.id
      response.should have_http_status(:ok)
    end
    it 'should invoice successfully' do
      delete :destroy, format: :json, id: 0
      response.should have_http_status(:not_found)
    end
  end
end
