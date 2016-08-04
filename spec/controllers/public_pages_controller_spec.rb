require 'rails_helper'

RSpec.describe PublicPagesController, type: :controller do
  describe 'GET #search' do
    it 'returns http success' do
      get :search
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #profile' do
    it 'returns http success' do
      get :profile
      expect(response).to have_http_status(:success)
    end
  end
end
