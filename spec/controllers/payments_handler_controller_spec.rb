require 'rails_helper'

RSpec.describe PaymentsHandlerController, type: :controller do

  describe "GET #deposit" do
    it "returns http success" do
      get :deposit
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #withdrawal" do
    it "returns http success" do
      get :withdrawal
      expect(response).to have_http_status(:success)
    end
  end

end
