require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  context 'GET' do
    it 'should all successfully' do
      get :index, format: :json
      response.should have_http_status(:ok)
    end

    it 'should order successfully' do
      order = create(:order)
      get :show, format: :json, id: order.id
      response.should have_http_status(:ok)
    end

    it 'should order not found' do
      get :show, format: :json, id: 0
      response.should have_http_status(:not_found)
    end
  end

  context 'POST' do
    it 'should order successfully' do
      get :new
      response.should have_http_status(:ok)
    end

    it 'should order successfully' do
      order = create(:order)
      get :edit, id: order.id
      response.should have_http_status(:ok)
    end

    it 'should order successfully' do
      get :edit, id: 0
      response.should_not have_http_status(:ok)
    end

    it 'should order successfully' do
      order = create(:order)
      post :create, format: :json, order: { item_id: order.item_id, user_id: order.user_id, payment_mode: order.payment_mode, payment_status: order.payment_status, order_status: order.order_status }
      response.should have_http_status(:ok)
    end

    it 'should order unsuccessfully' do
      post :create, format: :json, order: { item_id: '', user_id: '', payment_mode: '', payment_status: '', order_status: '' }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT' do
    it 'should order successfully' do
      order = create(:order)
      put :update, format: :json, id: order.id, order: { item_id: order.item_id, user_id: order.user_id, payment_mode: order.payment_mode, payment_status: order.payment_status, order_status: order.order_status }
      response.should have_http_status(:ok)
    end

    it 'should order unsuccessfully' do
      order = create(:order)
      put :update, format: :json, id: order.id, order: { item_id: '', user_id: '', payment_mode: '', payment_status: '', order_status: '' }
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should order unsuccessfully' do
      put :update, format: :json, id: 0
      response.should have_http_status(:not_found)
    end
  end

  context 'DELETE' do
    it 'should order successfully' do
      order = create(:order)
      delete :destroy, format: :json, id: order.id
      response.should have_http_status(:ok)
    end

    it 'should order successfully' do
      delete :destroy, format: :json, id: 0
      response.should have_http_status(:not_found)
    end
  end
end
