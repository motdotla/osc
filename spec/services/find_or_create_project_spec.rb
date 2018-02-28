require 'rails_helper'

RSpec.describe FindOrCreateProject, type: :model do
  fixtures :projects, :users

  let(:user) { users(:mot) }
  let(:project) { projects(:dotenv) }
  let(:url) { project.url }

  let(:service) { FindOrCreateProject.new(url: url) }

  describe '#run' do
    it 'finds the project' do
      result = service.run

      expect(result).to eql(project)
    end

    context 'when project url is nil' do
      it 'returns nil' do
        service.url = nil

        result = service.run

        expect(result).to eql(nil)
      end
    end

    context 'when project url has leading http' do
      it 'still finds the project' do
        service.url = "https://#{service.url}"

        result = service.run

        expect(result).to eql(project)
      end
    end

    context 'when project url has leading and/or appending space' do
      it 'still finds the project' do
        service.url = " #{service.url} "

        result = service.run

        expect(result).to eql(project)
      end
    end

    context 'when new project url' do
      it 'creates the project' do
        service.url = 'github.com/motdotla/node-lambda'

        expect { service.run }.to change(Project, :count).by(1)
      end

      context 'when user id is included' do
        it 'creates the project and associates it with the user' do
          service.user_id = user.id

          service.url = 'github.com/motdotla/node-lambda'

          expect { service.run }.to change(UserProject, :count).by(1)
        end
      end

      context 'when including http' do
        it 'create the project' do
          service.url = 'http://github.com/motdotla/node-lambda'

          project2 = service.run

          expect(project2.url).to eql('github.com/motdotla/node-lambda')
        end
      end

      context 'when including www' do
        it 'creates the project' do
          service.url = 'https://www.github.com/motdotla/node-lambda'

          project2 = service.run

          expect(project2.url).to eql('github.com/motdotla/node-lambda')
        end
      end
    end
  end
end
