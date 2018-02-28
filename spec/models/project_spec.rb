require 'rails_helper'

RSpec.describe Project, type: :model do
  fixtures :projects

  let(:project) { projects(:dotenv) }

  it 'is valid' do
    expect(project).to be_valid
  end

  it 'is not valid if missing url' do
    project.url = ''

    expect(project).to_not be_valid
  end

  it 'must be unique' do
    project2 = Project.new

    project2.url = project.url

    expect(project2).to_not be_valid
  end
end
