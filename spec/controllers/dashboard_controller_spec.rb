require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  describe 'GET #overview' do
    it 'returns http success' do
      get :overview
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #profile' do
    it 'returns http success' do
      get :profile
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #account' do
    it 'returns http success' do
      get :account
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #billing' do
    it 'returns http success' do
      get :billing
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #messages' do
    it 'returns http success' do
      get :messages
      expect(response).to have_http_status(:success)
    end
  end
end
