require 'rails_helper'

RSpec.describe PaypalController, type: :controller do
  describe 'GET #client_token' do
    it 'returns http success' do
      get :client_token
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #checkout' do
    it 'returns http success' do
      get :checkout
      expect(response).to have_http_status(:success)
    end
  end
end
