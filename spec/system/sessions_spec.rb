require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  let!(:user) { create(:user) }

  it 'ログイン失敗時にflashメッセージが残留しない' do
    visit login_path
    fill_in('session_email', with: 'test@example.com')
    fill_in('session_password', with: '')
    click_button('commit')
    expect(page).to have_selector 'div.alert-danger'
    visit root_path
    expect(page).not_to have_selector 'div.alert-danger'
  end

  it 'ログイン成功' do
    visit login_path
    fill_in('session_email', with: 'test@example.com')
    fill_in('session_password', with: 'foobar')
    click_button('commit')
    expect(current_path).to eq user_path(user.id)
  end
end
