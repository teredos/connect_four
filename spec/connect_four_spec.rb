# frozen_string_literal: true

require_relative '../lib/connect_four'

describe ConnectFour do
  let(:connect_four) { described_class.new }

  describe '#assign_circles' do
    before(:each) do
      allow(connect_four).to receive(:puts)
    end
    context 'when player input is valid' do
      before(:each) do
        allow(connect_four).to receive_message_chain(:gets,
                                                     :chomp).and_return('B')
      end
      it "doesn't output an error" do
        error = "Error: Only input 'B' or 'W' (case insensitive)"
        expect(connect_four).not_to receive(:puts).with(error)
        connect_four.assign_circles
      end
    end

    context 'when player input is invalid once, then valid' do
      before(:each) do
        allow(connect_four).to receive_message_chain(:gets, :chomp).and_return(
          '5', 'B'
        )
      end
      it 'outputs an error once' do
        error = "Error: Only input 'B' or 'W' (case insensitive)"
        expect(connect_four).to receive(:puts).with(error).once
        connect_four.assign_circles
      end
    end

    context 'when player input is invalid thrice, then valid' do
      before(:each) do
        allow(connect_four).to receive_message_chain(:gets, :chomp).and_return(
          'one', '2', 'three', 'W'
        )
      end
      it 'outputs an error thrice' do
        error = "Error: Only input 'B' or 'W' (case insensitive)"
        expect(connect_four).to receive(:puts).with(error).thrice
        connect_four.assign_circles
      end
    end
  end

  describe '#horizontal_winner?' do
    context "when 4 instances of player's circle are positioned horizontally in grid" do
      let(:horiz_grid) do
        double('Grid', positions: Array.new(6) do
                                    Array.new(7, '-')
                                  end.reverse)
      end
      it 'returns true' do
        grid = connect_four.instance_variable_set(:@grid, horiz_grid)
        player_circle = '○'
        four_circles = ['○', '○', '○', '○']
        grid.positions[0][0..3] = four_circles
        expect(connect_four.horizontal_winner?(player_circle)).to eq(true)
      end
    end
  end

  describe '#vertical_winner?' do
    context "when 3 instances of player's circle are positioned vertically in grid" do
      let(:vert_grid) do
        double('Grid', positions: Array.new(6) do
                                    Array.new(7, '-')
                                  end.reverse)
      end
      it 'returns false' do
        grid = connect_four.instance_variable_set(:@grid, vert_grid)
        player_circle = '○'
        grid.positions[0][0] = '○'
        grid.positions[1][0] = '○'
        grid.positions[2][0] = '○'
        expect(connect_four.vertical_winner?(player_circle)).to eq(false)
      end
    end
  end

  describe '#diagonal_winner?' do
    context "when 4 instances of player's circle are positioned diagonally in grid" do
      let(:diag_grid) do
        double('Grid', positions: Array.new(6) do
                                    Array.new(7, '-')
                                  end.reverse)
      end
      it 'returns true' do
        grid = connect_four.instance_variable_set(:@grid, diag_grid)
        player_circle = '○'
        diag_grid.positions[0][0] = '○'
        diag_grid.positions[1][1] = '○'
        diag_grid.positions[2][2] = '○'
        diag_grid.positions[3][3] = '○'
        expect(connect_four.diagonal_winner?(player_circle)).to eq(true)
      end
    end
  end
end
