require 'rails_helper'

RSpec.describe 'Homes', type: :request do
  describe 'GET /dashboard' do
    it 'returns http success' do
      get root_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /policy' do
    it 'returns http success' do
      get policy_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /private_policy' do
    it 'returns http success' do
      get private_policy_path
      expect(response).to have_http_status(:success)
    end
  end
end
