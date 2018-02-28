require 'rails_helper'

RSpec.describe FindOrCreateUser, type: :model do
  fixtures :users

  let(:user) { users(:mot) }

  let(:omniauth_response) do
    {
      'credentials' => {
        'token' => '12345'
      },
      'uid' => user.uid.split('|').last,
      'provider' => user.uid.split('|').first,
      'info' => {
        'name' => user.name,
        'nickname' => user.nickname,
        'image' => user.profile_photo_url,
        'email' => nil
      }
    }
  end

  let(:service) { FindOrCreateUser.new(omniauth_response: omniauth_response) }

  describe '#run' do
    it 'finds the user' do
      result = service.run

      expect(result).to eql(user)
    end

    context 'when user uid is nil' do
      it 'returns nil' do
        r = omniauth_response.deep_dup

        r['uid'] = nil

        service = FindOrCreateUser.new(omniauth_response: r)

        result = service.run

        expect(result).to eql(nil)
      end
    end

    context 'when new user uid' do
      it 'creates the user' do
        r = omniauth_response.deep_dup

        r['uid'] = 'github|9999'

        service = FindOrCreateUser.new(omniauth_response: r)

        expect { service.run }.to change(User, :count).by(1)
      end
    end
  end

  describe 'private' do
    describe '#oauth_token' do
      it 'returns' do
        result = service.send(:oauth_token)

        expect(result).to eql('12345')
      end
    end

    describe '#uid' do
      it 'returns' do
        result = service.send(:uid)

        expect(result).to eql(user.uid)
      end
    end

    describe '#name' do
      it 'returns' do
        result = service.send(:name)

        expect(result).to eql(user.name)
      end
    end

    describe '#nickname' do
      it 'returns' do
        result = service.send(:nickname)

        expect(result).to eql(user.nickname)
      end
    end

    describe '#profile_photo_url' do
      it 'returns' do
        result = service.send(:profile_photo_url)

        expect(result).to eql(user.profile_photo_url)
      end
    end

    describe '#provider' do
      it 'returns' do
        result = service.send(:provider)

        expect(result).to eql('github')
      end
    end
  end
end
