require 'rails_helper'

RSpec.describe 'Words', type: :request do
  describe 'GET /index' do
    it 'レスポンス成功' do
      get words_path
      expect(response).to have_http_status(:ok)
    end
  end
end
