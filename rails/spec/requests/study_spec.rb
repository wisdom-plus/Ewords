require 'rails_helper'

RSpec.describe 'Studies', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get study_index_path
      expect(response).to have_http_status(:success)
    end
  end
end
