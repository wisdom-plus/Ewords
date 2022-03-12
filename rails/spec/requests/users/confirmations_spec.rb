require 'rails_helper'

RSpec.describe 'Confirmations', type: :request do
  let(:user) {create(:user)}

  describe 'GET /users/confirmation/new' do
    it 'リクエストが成功' do
      get new_user_confirmation_path
      expect(response).to have_http_status(:ok)
    end
  end


  describe 'GET /users/confirmation' do

  end

  describe 'POST /users/confirmation' do

  end
end
