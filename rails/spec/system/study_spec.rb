require 'rails_helper'

RSpec.describe 'Study', type: :system, js: true do
  describe 'index' do
    it 'ボタンが表示される' do
      visit study_index_path
      expect(page).to have_link '学習する', href: word_study_index_path(level: 'primer',num: 0)
      expect(page).to have_link '学習する', href: word_study_index_path(level: 'basic',num: 0)
      expect(page).to have_link '学習する', href: word_study_index_path(level: 'abvance',num: 0)
      expect(page).to have_link '学習する', href: word_study_index_path(level: 'abbreviation',num: 0)
      expect(page).to have_link '学習する', href: word_study_index_path(level: 'initial',num: 0)
    end

  end

  describe 'show' do

  end

  describe 'result' do

  end
end
