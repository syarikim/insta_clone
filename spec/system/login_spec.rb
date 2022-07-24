require 'rails_helper'

RSpec.describe 'ログイン', type: :system do
  let(:user) { create(:user) }
  describe 'ログイン機能' do
    context 'ユーザが登録されていない場合' do
      it 'エラーメッセージが画面上に表示されること' do
        visit '/login'
        within '#login-form' do
          fill_in 'メールアドレス', with: 'wrong@example.com'
          fill_in 'パスワード', with: '12345678'
          click_on 'ログイン'
        end
        expect(page).to have_content 'ログインに失敗しました'
      end
    end

    context 'ユーザが登録済の場合' do
      it "ログインが成功すること" do
        visit '/login'
        within '#login-form' do
          fill_in 'メールアドレス', with: user.email
          fill_in 'パスワード', with: '12345678'
          click_on 'ログイン'
        end
        expect(page).to have_content 'ログインしました'
      end
    end
  end

  describe 'ログアウト機能' do
    before do
      login_as(user)
    end
    it 'ログアウトできること' do
      find("#header-avatar-dropdown").click
      accept_confirm{ click_on 'ログアウト'}
      expect(page).to have_content 'ログアウトしました'
    end
  end

  describe 'ヘッダーのメニュー文言' do
    context 'ログインしている時' do
      before do
        login_as(user)
      end
      it 'メニューの表示が適切であること' do
        visit '/'
        within '#header' do
          expect(page).not_to have_link 'ログイン', href: '/login'
          expect(page).not_to have_link 'サインアップ', href: '/signup'
          expect(page).to have_css '#header-avatar-dropdown'
        end
      end
    end
    context 'ログインしていない状態の場合' do
      it 'メニューの表示が適切であること' do
        visit '/'
        within '#header' do
          expect(page).to have_link 'ログイン', href: '/login'
          expect(page).to have_link 'サインアップ', href: '/signup'
          expect(page).not_to have_css '#header-avatar-dropdown'
        end
      end
    end
  end
end
