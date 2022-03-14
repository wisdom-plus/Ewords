require 'rails_helper'

RSpec.describe 'Users', type: :system do

  describe 'users/sign_up' do
    let(:user) { create(:user)}

    context 'success' do
      it 'ユーザーが作成される' do
        visit new_user_registration_path
        fill_in 'User Name',with: 'test'
        fill_in 'E-mail Address', with: 'test@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password Confirmation', with: 'password'
        click_button 'Create account'
        expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'
        expect(page).to have_current_path root_path
      end

      it 'ユーザーが作成される(パスワードが6文字)' do
        visit new_user_registration_path
        fill_in 'User Name',with: 'test'
        fill_in 'E-mail Address', with: 'test@example.com'
        fill_in 'Password', with: 'passwo'
        fill_in 'Password Confirmation', with: 'passwo'
        click_button 'Create account'
        expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'
        expect(page).to have_current_path root_path
      end


      it 'ユーザーが作成される(ユーザー名が2文字)' do
        visit new_user_registration_path
        fill_in 'User Name',with: 'te'
        fill_in 'E-mail Address', with: 'test@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password Confirmation', with: 'password'
        click_button 'Create account'
        expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'
        expect(page).to have_current_path root_path
      end
    end

    context 'failure' do
      it 'ユーザー名が1文字' do
        visit new_user_registration_path
        fill_in 'User Name',with: 't'
        fill_in 'E-mail Address', with: 'test@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password Confirmation', with: 'password'
        click_button 'Create account'
        expect(page).to have_current_path user_registration_path
      end

      it 'ユーザー名が空白' do
        visit new_user_registration_path
        fill_in 'User Name',with: ''
        fill_in 'E-mail Address', with: 'test@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password Confirmation', with: 'password'
        click_button 'Create account'
        expect(page).to have_current_path user_registration_path
      end

      it 'ユーザー名がスペース' do
        visit new_user_registration_path
        fill_in 'User Name',with: '     '
        fill_in 'E-mail Address', with: 'test@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password Confirmation', with: 'password'
        click_button 'Create account'
        expect(page).to have_current_path user_registration_path
      end

      it 'メールアドレスが空白' do
        visit new_user_registration_path
        fill_in 'User Name',with: 'test'
        fill_in 'E-mail Address', with: ''
        fill_in 'Password', with: 'password'
        fill_in 'Password Confirmation', with: 'password'
        click_button 'Create account'
        expect(page).to have_current_path user_registration_path
      end

      it 'メールアドレスがスペース' do
        visit new_user_registration_path
        fill_in 'User Name',with: 'test'
        fill_in 'E-mail Address', with: '      '
        fill_in 'Password', with: 'password'
        fill_in 'Password Confirmation', with: 'password'
        click_button 'Create account'
        expect(page).to have_current_path user_registration_path
      end

      it 'パスワードが5文字' do
        visit new_user_registration_path
        fill_in 'User Name',with: 'test'
        fill_in 'E-mail Address', with: 'test@example.com'
        fill_in 'Password', with: 'passw'
        fill_in 'Password Confirmation', with: 'passw'
        click_button 'Create account'
        expect(page).to have_current_path user_registration_path
      end

      it 'パスワードが一致しない' do
        visit new_user_registration_path
        fill_in 'User Name',with: 'test'
        fill_in 'E-mail Address', with: 'test@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password Confirmation', with: 'anotherpassword'
        click_button 'Create account'
        expect(page).to have_current_path user_registration_path
      end
    end
  end
end
