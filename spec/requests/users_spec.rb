require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:test_user) { create(:user) }
  let!(:mike) { create(:user2) }
  let!(:user_params1) { { name: 'test2', email: 'test2@example.com', password: 'foo34wwbb', password_confirmation: 'foo34wwbb' } }
  let!(:user_params2) { { name: '', email: 'user@test.com', password: 'foobar', password_confirmation: 'foobar' } }
  let!(:user_params3) { { name: 'user_test', email: 'user3@test.com', password: '', password_confirmation: '' } }

  describe 'GET /index' do
    it 'ログインしてないときは、まずログインさせる' do
      get users_path
      expect(response).to redirect_to(login_url)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get signup_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      log_in_as(test_user)
      get edit_user_path(test_user.id)
      expect(response).to have_http_status(:success)
    end

    it 'ログインしてないとログインを要求する' do
      get edit_user_path(test_user.id)
      expect(flash.empty?).to eq false
      assert_redirected_to login_url
    end

    it '異なるユーザは編集できない' do
      log_in_as(mike)
      get edit_user_path(test_user.id)
      expect(flash.empty?).to eq true
      expect(response).to redirect_to(root_url)
    end
  end

  describe 'POST /create' do
    context '正常系' do
      it 'Userが作成できる' do
        expect do
          post users_path, params: { user: user_params1 }
        end.to change { User.count }.by(1)
      end

      it '詳細画面にリダイレクトされる' do
        post users_path, params: { user: user_params1 }
        u = User.find_by(name: 'test2')
        expect(response).to redirect_to(user_path(u.id))
      end
    end

    context '異常系' do
      it 'nameが空なのでUserが作成できない' do
        expect do
          post users_path, params: { user: { name:  '', email: 'user@invalid',
                                    password: 'foo', password_confirmation: 'bar' } }
        end.to change { User.count }.by(0)
      end

      it 'Userが作成できないときは、newページがレンダリングされる' do
        post users_path, params: { user: { name:  '', email: 'user@invalid',
                                  password: 'foo', password_confirmation: 'bar' } }
        expect(response).to render_template 'new'
      end
    end
  end


  describe 'PATCH /update' do
    context '正常系' do
      it 'passwordが空でも更新できる' do
        log_in_as(test_user)
        patch user_path(test_user.id), params: { user: user_params3 }
        expect(test_user.reload[:name]).to eq 'user_test'
      end
    end

    context '異常系' do
      it 'ログインしてないとログインを要求する' do
        patch user_path(test_user.id), params: { user: user_params3 }
        expect(flash.empty?).to eq false
        assert_redirected_to login_url
      end

      it 'nameが空なのでUserを更新できない' do
        patch user_path(test_user.id), params: { user: user_params2 }
        expect(test_user.reload[:name]).to eq 'test'
      end

      it '異なるユーザは編集できない' do
        log_in_as(mike)
        patch user_path(test_user.id), params: { user: user_params3 }
        expect(flash.empty?).to eq true
        expect(response).to redirect_to(root_url)
      end
    end
  end
end
