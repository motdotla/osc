require 'rails_helper'

RSpec.describe NewProject, type: :model do
  fixtures :projects

  let(:project) { projects(:dotenv) }

  let(:url) { 'https://github.com/motdotla/digitalocean' }

  let(:attrs) do
    {
      url: url
    }
  end

  let(:form) { NewProject.new(attrs) }

  describe 'initialize' do
    it 'sets url' do
      expect(form.url).to eql(url)
    end
  end

  describe '#valid' do
    it { expect(form).to be_valid }

    context 'when url already existed' do
      it 'is still valid' do
        form.url = project.url
        expect(form).to be_valid
      end
    end

    context 'when url is missing' do
      it 'is not valid' do
        form.url = ''
        expect(form).to_not be_valid
      end
    end

    context 'when not a url' do
      it 'is not valid' do
        form.url = 'djfkdjfkdf'
        expect(form).to_not be_valid
      end
    end
  end
end

