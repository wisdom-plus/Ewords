require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { create(:user) }

  before do
    ActionMailer::Base.deliveries.clear
  end

  describe 'users/password/new' do
    context 'success' do
      it 'メールが送信される' do
        user.confirm
        visit new_user_password_path
        fill_in 'E-mail Address',with: user.email
        click_button 'Recover password'
        expect(page).to have_content 'パスワードの再設定について数分以内にメールでご連絡いたします。'
        expect(page).to have_current_path new_user_session_path
      end

      it 'メールが送信される(送信メールの数が増えている)' do
        user.confirm
        visit new_user_password_path
        fill_in 'E-mail Address',with: user.email
        expect { click_button 'Recover password' }.to change { ActionMailer::Base.deliveries.size }.by(1)
      end
    end

    context 'failure' do
      it '登録されていないメールアドレスの時は送信されない' do
        visit new_user_password_path
        fill_in 'E-mail Address',with: 'another@example.com'
        expect { click_button 'Recover password' }.to change { ActionMailer::Base.deliveries.size }.by(0)
      end
    end
  end

  describe 'users/password/edit' do
    before do
      @raw, enc = Devise.token_generator.generate(User, :reset_password_token)
      user.reset_password_token = enc
      user.reset_password_sent_at = (4.hours.ago)
      user.save(validate: false)
    end

    context 'success' do
      it 'パスワードが変更できる' do
        visit edit_user_password_path(@resources, reset_password_token: @raw)
        fill_in 'Password',with: 'newpassword'
        fill_in 'Password Confirmation',with: 'newpassword'
        click_button 'Recover password'
        expect(page).to have_content "パスワードが正しく変更されました。\nメールアドレスの本人確認が必要です。"
        expect(page).to have_current_path new_user_session_path
      end

      it 'パスワードが変更できる(6文字)' do
        visit edit_user_password_path(@resources, reset_password_token: @raw)
        fill_in 'Password',with: 'newpass'
        fill_in 'Password Confirmation',with: 'newpass'
        click_button 'Recover password'
        expect(page).to have_content "パスワードが正しく変更されました。\nメールアドレスの本人確認が必要です。"
        expect(page).to have_current_path new_user_session_path
      end

      it '前回のパスワードでも登録できる' do
        visit edit_user_password_path(@resources, reset_password_token: @raw)
        fill_in 'Password',with: user.password
        fill_in 'Password Confirmation',with: user.password
        click_button 'Recover password'
        expect(page).to have_current_path new_user_session_path
      end
    end

    context 'failure' do
      it 'トークンが違う' do
        visit edit_user_password_path(@resources, reset_password_token: 'another_token')
        fill_in 'Password',with: 'newpass'
        fill_in 'Password Confirmation',with: 'newpass'
        click_button 'Recover password'
        expect(page).to have_current_path user_password_path
      end

      it 'パスワードが短い(5文字)' do
        visit edit_user_password_path(@resources, reset_password_token: @raw)
        fill_in 'Password',with: 'newpa'
        fill_in 'Password Confirmation',with: 'newpa'
        click_button 'Recover password'
        expect(page).to have_current_path user_password_path
      end

      it 'パスワードが一致しない' do
        visit edit_user_password_path(@resources, reset_password_token: @raw)
        fill_in 'Password',with: 'newpassword'
        fill_in 'Password Confirmation',with: 'anotherpassword'
        click_button 'Recover password'
        expect(page).to have_current_path user_password_path
      end
    end
  end
end
