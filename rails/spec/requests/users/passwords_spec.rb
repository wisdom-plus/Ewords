require 'rails_helper'

RSpec.describe 'Passwords', type: :request do
  let(:user) { create(:user) }

  describe 'GET /usrs/password/new' do
    it 'リクエストが成功' do
      get new_user_password_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /users/password/edit' do
    context 'success' do
      before do
        @raw, enc = Devise.token_generator.generate(User, :reset_password_token)
        user.reset_password_token = enc
        user.reset_password_sent_at = (4.hours.ago)
        user.save(validate: false)
      end

      it 'リクエストが成功' do
        get edit_user_password_path(@resources, reset_password_token: @raw)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'failure' do
      it 'リクエストが失敗(リセットトークンが保存されていない)' do
        get edit_user_password_path(@resources, reset_password_token: @raw)
        expect(response).to have_http_status(:found)
      end
    end
  end

  describe 'POST /users/password' do
    it 'リクエストが成功' do
      post user_password_path, params: { user: { email: user.email } }
      expect(response).to have_http_status(:found)
    end
  end

  describe 'PATCH /users/password' do
    context 'success' do
      before do
        @raw, enc = Devise.token_generator.generate(User, :reset_password_token)
        user.reset_password_token = enc
        user.reset_password_sent_at = (4.hours.ago)
        user.save(validate: false)
      end

      it 'リクエストが成功' do
        patch user_password_path, params: { user: { reset_password_token: @raw, password: 'another_password', password_confirmation: 'another_password' } }
        expect(response).to have_http_status(:found)
      end

      it 'リクエストが成功(パスワードが6文字)' do
        patch user_password_path, params: { user: { reset_password_token: @raw, password: 'passwo', password_confirmation: 'passwo' } }
        expect(response).to have_http_status(:found)
      end
    end

    context 'failure' do
      before do
        @raw, enc = Devise.token_generator.generate(User, :reset_password_token)
        user.reset_password_token = enc
        user.reset_password_sent_at = (4.hours.ago)
        user.save(validate: false)
      end

      it 'リクエストが失敗(トークンが違う)' do
        patch user_password_path, params: { user: { reset_password_token: 'another_token', password: 'another_password', password_confirmation: 'another_password' } },xhr: true
        expect(response).to have_http_status(:ok)
      end

      it 'リクエストが失敗(パスワードが短い5文字)' do
        patch user_password_path, params: { user: { reset_password_token: @raw, password: 'passw', password_confirmation: 'passw' } },xhr: true
        expect(response).to have_http_status(:ok)
      end

      it 'リクエストが失敗(パスワードが一致しない)' do
        patch user_password_path, params: { user: { reset_password_token: @raw, password: 'another_password', password_confirmation: 'password' } },xhr: true
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
