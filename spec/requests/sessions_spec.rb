require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let!(:user) { create(:user) }

  describe 'GET /new' do
    it 'returns http success' do
      get login_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'remember機能を使ってログイン' do
    it 'remember on' do
      log_in_as(user, remember_me: '1')
      expect(!session[:user_id].blank?).to eq true
      expect(!cookies[:remember_token].blank?).to eq true
    end

    it 'remember off' do
      log_in_as(user, remember_me: '1')
      delete logout_path
      log_in_as(user, remember_me: '0')
      expect(cookies[:remember_token].blank?).to eq true
    end
  end

  describe 'POST /login' do
    it 'login' do
      post login_path, params: { session: { email: 'test@example.com', password: 'foobar' } }
      expect(!session[:user_id].nil?).to eq true
    end
  end

  describe 'DELETE /logout' do
    it 'logout' do
      post login_path, params: { session: { email: 'test@example.com', password: 'foobar' } }
      delete logout_path
      expect(session[:user_id].nil?).to eq true
    end
  end
end
