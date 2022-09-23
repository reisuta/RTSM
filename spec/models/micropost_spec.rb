require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let!(:user) { create(:user) }
  let!(:micropost) { user.microposts.create(content: 'Lorem ipsum') }

  describe 'validation' do
    it 'user id should be present' do
      micropost.user_id = nil
      expect(micropost.valid?).to eq false
    end

    it 'content should be present' do
      micropost.content = '   '
      expect(micropost.valid?).to eq false
    end

    it 'content should be at most 140 characters' do
      micropost.content = 'a' * 141
      expect(micropost.valid?).to eq false
    end
  end
end
