require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { create(:user) }

  before do
    ActionMailer::Base.deliveries.clear
  end

  describe 'confirmation/new' do
    context 'success' do
      it 'メールが送信される' do
        visit new_user_confirmation_path
        fill_in 'E-mail Address', with: user.email
        click_button 'Send'
        expect(page).to have_content 'アカウントの有効化について数分以内にメールでご連絡します。'
        expect(page).to have_current_path new_user_session_path
      end

      it 'メールが送信される(送信メールの数が増えている)' do
        visit new_user_confirmation_path
        fill_in 'E-mail Address', with: user.email
        expect { click_button 'Send' }.to change { ActionMailer::Base.deliveries.size }.by(1)
      end
    end

    context 'failure' do
      it '違うメールアドレスの時' do
        visit new_user_confirmation_path
        fill_in 'E-mail Address', with: 'another@example.com'
        click_button 'Send'
        expect(page).to have_current_path user_confirmation_path
        expect { click_button 'Send' }.to change { ActionMailer::Base.deliveries.size }.by(0)
      end
    end
  end
end
