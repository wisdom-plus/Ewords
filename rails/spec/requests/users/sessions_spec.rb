require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let(:user) {create(:user)}

  describe "GET /sign_in" do
    it "リクエストが成功" do
      get new_user_session_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /sign_in" do
    before do
      user.confirm
    end

    context 'success' do
      it 'リクエストが成功' do
        post user_session_path,params: {user:{ email: user.email,password: user.password,remember_me: '0'}}, xhr: true
        expect(response).to have_http_status(302)
        expect(response).to redirect_to root_path
      end
    end
    context 'failure' do
      it 'リクエストに失敗(email)' do
        post user_session_path,params: {user:{ email: 'miss@example.com',password: user.password,remember_me: '0'}}, xhr: true
        expect(response).to have_http_status(401)
      end

      it 'リクエストに失敗(password間違い)' do
        post user_session_path,params: {user:{ email: user.email,password: 'misspassword',remember_me: '0'}}, xhr: true
        expect(response).to have_http_status(401)
      end

      it 'リクエストに失敗(password足りない)' do
        post user_session_path,params: {user:{ email: user.email,password: 'miss',remember_me: '0'}}, xhr: true
        expect(response).to have_http_status(401)
      end

      it 'リクエストに失敗(空白)' do
        post user_session_path,params: {user:{ email: user.email,password: '        ',remember_me: '0'}}, xhr: true
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'DELETE /sign_out' do
    it 'リクエストが成功' do
      user.confirm
      sign_in user
      delete destroy_user_session_path, xhr: true
      expect(response).to have_http_status(303)
      expect(response).to redirect_to root_path
    end

    it 'リクエストが失敗(ログインをしていない)' do
      delete destroy_user_session_path, xhr: true
      expect(response).to have_http_status(303)
      expect(response).to redirect_to root_path
    end
  end
end
