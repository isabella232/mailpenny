require 'rails_helper'

RSpec.describe PublicPagesController, type: :controller do
  describe 'GET #search' do
    it 'returns http success' do
      get :search
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #profile for user with profile' do
    it 'returns http success' do
      user = create(:user)
      user.profile = build :profile
      get :profile, params: { username: user.username }
      expect(response).to have_http_status(:success)
    end
  end
end
