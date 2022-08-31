require 'rails_helper'

RSpec.describe '投稿', type: :system do
  let(:user) { create(:user) }
  before do
    login_as(user)
  end
  describe '投稿' do
    it '投稿できること' do
      within '#header' do
        click_on '投稿'
      end
      fill_in '本文', with: 'てきすとです'
      attach_file '画像', Rails.root.join('spec', 'fixtures', 'dummy.jpg')
      click_on '登録する'
      expect(page).to have_content '投稿しました'
    end
  end

  describe '編集' do
    let!(:post) { create(:post, user: user) }
    it '編集ができること' do
      visit "/posts/#{post.id}"
      find('#postDropdownMenuLink').click
      click_on '編集'
      fill_in '本文', with: 'てきすとを更新しました'
      click_on '更新する'
      expect(page).to have_content '投稿を更新しました'
      expect(page).to have_content 'てきすとを更新しました'
    end
  end

  describe '削除' do
    let!(:post) { create(:post, user: user) }
    it '削除ができること' do
      visit "/posts/#{post.id}"
      find('#postDropdownMenuLink').click
      accept_confirm { click_on '削除' }
      expect(page).to have_content '投稿を削除しました'
    end
  end

  describe 'ページネーション' do
    let!(:post) { create(:post, created_at: Time.current.yesterday) }
    before do
      create_list(:post, 15)
    end
    it '16件目のポストは1ページ目に表示されていないこと' do
      expect(page).not_to have_css("#post_#{post.id}")
    end
  end
end

