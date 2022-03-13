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
end
