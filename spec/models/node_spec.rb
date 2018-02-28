require 'rails_helper'

RSpec.describe Node, type: :model do
  fixtures :nodes

  let(:node) { nodes(:machine1) }

  it 'is valid' do
    expect(node).to be_valid
  end

  it 'is not valid if missing machine_id' do
    node.machine_id = ''

    expect(node).to_not be_valid
  end

  it 'must be unique' do
    node2 = Node.new

    node2.machine_id = node.machine_id

    expect(node2).to_not be_valid
  end
end
