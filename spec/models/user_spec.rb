require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }

  describe 'validation' do
    it 'valid' do
      expect(user).to be_valid
    end

    context 'presence' do
      it 'nameが空の場合' do
        invalid_user = User.new(name: '', email: 'example@example.com', password: 'password', password_confirmation: 'password')
        expect(invalid_user).not_to be_valid
      end

      it 'emailが空の場合' do
        invalid_user = User.new(name: 'test_user', email: '', password: 'password', password_confirmation: 'password')
        expect(invalid_user).not_to be_valid
      end
    end

    context '長さの検証' do
      it 'nameが51文字以上のとき、作成できない' do
        invalid_user = User.new(name: 'a' * 51, email: 'test@co.jp', password: 'password', password_confirmation: 'password')
        expect(invalid_user).not_to be_valid
      end

      it 'emailが256文字以上のとき、作成できない' do
        invalid_user = User.new(name: 'test', email: 'a' * 250 + '@co.jp', password: 'password', password_confirmation: 'password')
        expect(invalid_user).not_to be_valid
      end
    end

    context 'emailの有効性の検証' do
      it '有効なemail' do
        valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                           first.last@foo.jp alice+bob@baz.cn]
        valid_addresses.each do |valid_address|
          valid_user = User.new(name: 'test', email: valid_address, password: 'password', password_confirmation: 'password')
          expect(valid_user).to be_valid
        end
      end

      it '無効なemail' do
        invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
        invalid_addresses.each do |invalid_address|
          invalid_user = User.new(name: 'test', email: invalid_address, password: 'password', password_confirmation: 'password')
          expect(invalid_user).not_to be_valid
        end
      end

      it '重複したemailは作成できない' do
        @user = User.new(name: 'Example User', email: 'user@example.com', password: 'password', password_confirmation: 'password')
        duplicate_user = @user.dup
        @user.save
        expect(duplicate_user).not_to be_valid
      end
    end

    context 'password' do
      before do
        @user = User.new(name: 'Example User', email: 'user@example.com', password: 'password', password_confirmation: 'password')
      end

      it 'passwordが空白でないこと' do
        @user.password = @user.password_confirmation = ' ' * 6
        expect(@user).not_to be_valid
      end

      it 'passwordが最小文字数以上であること' do
        @user.password = @user.password_confirmation = 'a' * 5
        expect(@user).not_to be_valid
      end
    end
  end
end
