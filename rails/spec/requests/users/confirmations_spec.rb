require 'rails_helper'

RSpec.describe 'Confirmations', type: :request do
  describe 'GET /confirmations' do
    it 'リクエストが成功' do
      get new_user_confirmation_path
      expect(response).to have_http_status(:ok)
    end
  end
end
