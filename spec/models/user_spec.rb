require 'rails_helper'

RSpec.describe User, type: :model do
  fixtures :users

  let(:user) { users(:mot) }

  it 'is valid' do
    expect(user).to be_valid
  end

  describe '#uid' do
    it 'is not valid if missing' do
      user.uid = ''

      expect(user).to_not be_valid
    end

    it 'must be unique' do
      user2 = User.new

      user2.uid = user.uid

      expect(user2).to_not be_valid
    end
  end
end
