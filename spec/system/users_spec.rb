require 'rails_helper'

RSpec.describe 'Users', type: :system do
  it 'ユーザーが作成できる' do
    expect {
      visit signup_path
      fill_in('user_name', with: 'akira')
      fill_in('user_email', with: 'sample@co.jp')
      fill_in('user_password', with: 'aaa11112')
      fill_in('user_password_confirmation', with: 'aaa11112')
      click_button('Create my account')
      expect(page).to have_selector 'div.alert-success'
    }.to change { User.count }.by(1)
  end

  it 'ユーザーが作成できない' do
    expect {
      visit signup_path
      fill_in('user_name', with: '')
      fill_in('user_email', with: 'sample@co.jp')
      fill_in('user_password', with: 'aaa11112')
      fill_in('user_password_confirmation', with: 'aaa11112')
      click_button('Create my account')
      expect(page).to have_selector 'div.alert-danger'
    }.to change { User.count }.by(0)
  end
end
