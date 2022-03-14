require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { create(:user) }

  describe 'sign_in' do
    before do
      user.confirm
      visit new_user_session_url
    end

    context 'success' do
      it 'ログインに成功(remember meなし)' do
        fill_in 'E-mail address', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Log in'
        expect(page).to have_content 'ログインしました。'
        expect(page).to have_current_path root_path
      end

      it 'ログインに成功' do
        fill_in 'E-mail address', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Log in'
        expect(page).to have_content 'ログインしました。'
        expect(page).to have_current_path root_path
      end
    end

    context 'failure' do
      it 'メールアドレスが違う' do
        fill_in 'E-mail address', with: 'miss@exaple.com'
        fill_in 'Password', with: user.password
        click_button 'Log in'
        expect(page).to have_content 'Eメールまたはパスワードが違います。'
        expect(page).to have_current_path new_user_session_path
      end

      it 'パスワードが違う' do
        fill_in 'E-mail address', with: user.email
        fill_in 'Password', with: 'misspassword'
        click_button 'Log in'
        expect(page).to have_content 'Eメールまたはパスワードが違います。'
        expect(page).to have_current_path new_user_session_path
      end
    end
  end

  describe 'sign_out' do
    it 'ログアウトされる' do
      login(user)
      visit root_path
      click_on 'ログアウト'
      expect(page).to have_content 'ログアウトしました。'
      expect(page).to have_current_path root_path
    end

    it 'ログインしていないときログアウトボタンが出てこない' do
      visit root_path
      expect(page).to have_no_button 'ログアウト'
    end
  end
end
