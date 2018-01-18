require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  describe 'GET #index' do
    it 'should return http success' do
      get :index
      response.should have_http_status(:success)
    end
  end
end
