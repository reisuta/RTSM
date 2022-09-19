require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let!(:user) { create(:user) }

  describe 'GET /new' do
    it 'returns http success' do
      get login_path
      expect(response).to have_http_status(:success)
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
