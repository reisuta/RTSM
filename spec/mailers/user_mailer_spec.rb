require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'account_activation' do
    let(:user) { create(:user) }
    let(:mail) { UserMailer.account_activation(user) }

    it 'renders the headers' do
      user.activation_token = User.new_token
      expect(mail.subject).to eq('Account activation')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['noreply@example.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Hi')
    end
  end

  describe 'password_reset' do
    let(:user) { create(:user) }
    let(:mail) { UserMailer.password_reset(user) }

    it 'renders the headers' do
      user.reset_token = User.new_token
      expect(mail.subject).to eq('Password reset')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['noreply@example.com'])
    end

    #     it 'renders the body' do
    #       expect(mail.body.encoded).to match('Hi')
    #     end
  end
end
