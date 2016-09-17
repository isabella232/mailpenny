require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  before do
    sign_in create(:user)
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

  describe 'GET #inbox' do
    it 'returns http success' do
      get :inbox
      expect(response).to have_http_status(:success)
    end
  end
end
