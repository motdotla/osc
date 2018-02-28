require 'rails_helper'

RSpec.describe FindOrCreateNode, type: :model do
  fixtures :nodes

  let(:user) { users(:mot) }
  let(:node) { nodes(:machine1) }
  let(:machine_id) { node.machine_id }

  let(:service) { FindOrCreateNode.new(machine_id: machine_id) }

  describe '#run' do
    it 'finds the node' do
      result = service.run

      expect(result).to eql(node)
    end

    it 'updates the pinged_at value' do
      prior_pinged_at = node.pinged_at

      result = service.run

      expect(result.pinged_at).to_not eql(prior_pinged_at)
    end

    context 'when node machine_id is nil' do
      it 'returns nil' do
        service.machine_id = nil

        result = service.run

        expect(result).to eql(nil)
      end
    end

    context 'when new node machine_id' do
      it 'creates the node' do
        service.machine_id = 'some-different-id'

        expect { service.run }.to change(Node, :count).by(1)
      end
    end
  end
end
