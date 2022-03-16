require 'rails_helper'

RSpec.describe 'Other', type: :system, js: true do
  let(:user) { create(:user) }

  describe 'Flash message' do
    it 'フラッシュメッセージが表示される(notice)' do
      login(user)
      expect(page).to have_selector '#flash-message-notice', text: 'ログインしました。'
    end

    it 'フラッシュメッセージが表示される(alert)' do
      login(user)
      click_on 'ログアウト'
      expect(page).to have_selector '#flash-message-notice', text: 'ログアウトしました。'
    end

    it 'フラッシュメッセージが消せる(notice)' do
      login(user)
      expect(page).to have_selector '#flash-message-notice', text: 'ログインしました。'
      find('.flash-delete-button').click
      expect(page).to have_no_selector '#flash-message-notice', text: 'ログインしました。'
    end

    it 'フラッシュメッセージが消せる(alert)' do
      login(user)
      click_on 'ログアウト'
      expect(page).to have_selector '#flash-message-notice', text: 'ログアウトしました。'
      find('.flash-delete-button').click
      expect(page).to have_no_selector '#flash-message-notice', text: 'ログアウトしました。'
    end
  end
end
