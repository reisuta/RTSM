require 'rails_helper'

RSpec.describe 'StaticPages', type: :request do
  before do
    @base_title = 'Ruby on Rails Tutorial Sample App'
  end

  describe 'GET /' do
    it 'returns http success' do
      get '/'
      expect(response).to have_http_status(:success)
      assert_select 'title', "Home | #{@base_title}"
    end
  end

  describe 'GET /home' do
    it 'returns http success' do
      get '/static_pages/home'
      expect(response).to have_http_status(:success)
      assert_select 'title', "Home | #{@base_title}"
    end
  end

  describe 'GET /help' do
    it 'returns http success' do
      get '/static_pages/help'
      expect(response).to have_http_status(:success)
      assert_select 'title', "Help | #{@base_title}"
    end
  end

  describe 'GET /about' do
    it 'returns http success' do
      get '/static_pages/about'
      expect(response).to have_http_status(:success)
      assert_select 'title', "About | #{@base_title}"
    end
  end
end
