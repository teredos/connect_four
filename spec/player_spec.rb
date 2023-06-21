# frozen_string_literal: true

require_relative '../lib/player'

describe Player do
  let(:player) { described_class.new }

  describe '#set_name' do
    context 'when player inputs a name' do
      it 'returns player input' do
        name = 'Alfred'
        allow(player).to receive(:puts)
        allow(player).to receive_message_chain(:gets, :chomp).and_return(name)
        expect(player.create_name(1)).to eq(name)
      end
    end
  end

  describe '#assign_circle' do
    context 'when a circle is input' do
      it 'returns circle input' do
        circle = '○'
        expect(player.assign_circle(circle)).to eq(circle)
      end
    end
  end
end
