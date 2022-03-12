require 'rails_helper'

RSpec.describe 'Confirmations', type: :request do
  let(:user) { create(:user) }

  describe 'GET /users/confirmation/new' do
    it 'リクエストが成功' do
      get new_user_confirmation_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /users/confirmation' do
    context 'success' do
      before do
        @raw, enc = Devise.token_generator.generate(User, :confirmation_token)
        user.confirmation_token = enc
        user.confirmation_sent_at = (4.hours.ago)
        user.save(validate: false)
      end

      it 'リクエストが成功' do
        get user_confirmation_path(confirmation_token: @raw)
        expect(response).to have_http_status(:found)
      end
    end

    context 'failure' do
      before do
        @raw, enc = Devise.token_generator.generate(User, :confirmation_token)
        user.confirmation_token = enc
        user.confirmation_sent_at = (1.hour.ago)
        user.save(validate: false)
      end

      it 'リクエストが失敗(トークンが違う)' do
        get user_confirmation_path(confirmation_token: 'another_token'), xhr: true
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST /users/confirmation' do
    it 'リクエストが成功' do
      post user_confirmation_path, params: { user: { email: user.email } }
      expect(response).to have_http_status(:found)
    end

    it 'リクエストが失敗(登録されていないメールアドレス)' do
      post user_confirmation_path, params: { user: { email: 'another@example.com' } }, xhr: true
      expect(response).to have_http_status(:ok)
    end
  end
end
