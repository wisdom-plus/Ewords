require 'rails_helper'

RSpec.describe 'Registrations', type: :request do
  let(:user) { create(:user) }

  describe 'GET /sign_up' do
    it 'リクエストが成功' do
      get new_user_registration_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /users' do
    context 'success' do
      it 'リクエストが成功' do
        post user_registration_path, params: { user: { name: 'test', email: 'test@example.com', password: 'password', password_confirmation: 'password' } }, xhr: true
        expect(response).to have_http_status(:found)
      end

      it 'ユーザーが作成される' do
        expect do
          post user_registration_path, params: { user: { name: 'test', email: 'test@example.com', password: 'password', password_confirmation: 'password' } }, xhr: true
        end.to change(User, :count).by 1
      end

      it 'ユーザーが作成される(nameが2文字)' do
        expect do
          post user_registration_path, params: { user: { name: 'te', email: 'test@example.com', password: 'password', password_confirmation: 'password' } }, xhr: true
        end.to change(User, :count).by 1
      end

      it 'ユーザーが作成される(passwordが6文字)' do
        expect do
          post user_registration_path, params: { user: { name: 'test', email: 'test@example.com', password: 'passwo', password_confirmation: 'passwo' } }, xhr: true
        end.to change(User, :count).by 1
      end
    end

    context 'failure' do
      it 'リクエストが失敗(nameが空)' do
        post user_registration_path, params: { user: { name: '', email: 'test@example.com', password: 'password', password_confirmation: 'password' } }, xhr: true, headers: { Accept: 'text/vnd.turbo-stream.html' }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'リクエストが失敗(nameが1文字)' do
        post user_registration_path, params: { user: { name: 't', email: 'test@example.com', password: 'password', password_confirmation: 'password' } }, xhr: true, headers: { Accept: 'text/vnd.turbo-stream.html' }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'リクエストが失敗(nameで空文字が2文字)' do
        post user_registration_path, params: { user: { name: '  ', email: 'test@example.com', password: 'password', password_confirmation: 'password' } }, xhr: true, headers: { Accept: 'text/vnd.turbo-stream.html' }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'リクエストが失敗(emailが空)' do
        post user_registration_path, params: { user: { name: 'test', email: '', password: 'password', password_confirmation: 'password' } }, xhr: true, headers: { Accept: 'text/vnd.turbo-stream.html' }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'リクエストが失敗(passwordが空)' do
        post user_registration_path, params: { user: { name: 'test', email: 'test@example.com', password: '', password_confirmation: 'password' } }, xhr: true, headers: { Accept: 'text/vnd.turbo-stream.html' }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'リクエストが失敗(passwordが5文字)' do
        post user_registration_path, params: { user: { name: 'test', email: 'test@example.com', password: 'passw', password_confirmation: 'passw' } }, xhr: true, headers: { Accept: 'text/vnd.turbo-stream.html' }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'リクエストが失敗(password_confirmationが空)' do
        post user_registration_path, params: { user: { name: 'test', email: 'test@example.com', password: 'password', password_confirmation: '' } }, xhr: true, headers: { Accept: 'text/vnd.turbo-stream.html' }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'リクエストが失敗(passwordとpassword_confirmationが一致しない)' do
        post user_registration_path, params: { user: { name: 'test', email: 'test@example.com', password: 'password', password_confirmation: 'misspassword' } }, xhr: true, headers: { Accept: 'text/vnd.turbo-stream.html' }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET /users/edit' do
    it 'リクエストが成功' do
      user.confirm
      sign_in user
      get edit_user_registration_path
      expect(response).to have_http_status(:ok)
    end
  end
end
