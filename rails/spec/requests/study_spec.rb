require 'rails_helper'

RSpec.describe 'Studies', type: :request do
  let(:word) {create(:word)}
  let(:word1) {create(:word,word: 'test1',reading: 'テスト1',level: 1,kind: 1)}

  describe 'GET /study' do
    it 'returns http success' do
      get study_index_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'Get /words/level/:num' do
    it 'returns http success' do
      word
      get word_study_index_path(num: 0,level: 'basic')
      expect(response).to have_http_status(:success)
    end
  end
end
