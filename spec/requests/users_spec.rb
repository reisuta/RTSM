require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /new' do
    it 'returns http success' do
      get signup_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    let!(:user_params) { { name: 'test', email: 'test@example.com', password: 'foo34wwbb', password_confirmation: 'foo34wwbb' } }
    context '正常系' do
      it 'Userが作成できる' do
        expect do
          post users_path, params: { user: user_params }
        end.to change { User.count }.by(1)
      end

      it '詳細画面にリダイレクトされる' do
        post users_path, params: { user: user_params }
        user = User.find_by(name: 'test')
        expect(response).to redirect_to(user_path(user.id))
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
end
