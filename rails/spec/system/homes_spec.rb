require 'rails_helper'

RSpec.describe "Home", type: :system,js: true do
  describe 'policy' do
    it '画面が表示される' do
      visit root_path
      find(".setting_button").click
      find(".policy_link").click
      expect(page).to have_current_path policy_path
    end
  end

  describe 'private_policy' do
    it '画面が表示される' do
      visit root_path
      find(".setting_button").click
      find(".private_link").click
      expect(page).to have_current_path private_policy_path
    end
  end
end
