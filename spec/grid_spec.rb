# frozen_string_literal: true

require_relative '../lib/grid'

describe Grid do
  let(:grid) { described_class.new(6, 7) }
  describe '#new_grid' do
    context 'when given a valid row and column number' do
      it "returns an array with 'row' number of elements" do
        expect(grid.new_grid(6, 7).length).to eq(6)
      end
      it "returns an array of nested arrays, each with 'column' number of elements" do
        expect(grid.new_grid(6, 7).all? { |e| e.length == 7 }).to eq(true)
      end
    end
  end

  describe '#update' do
    context 'when input is valid' do
      it "changes first empty position in chosen column to player's circle" do
        choice = 5
        circle = '○'
        allow(grid).to receive(:show)
        expect { grid.update(choice, circle) }.to change {
                                                    grid.positions[0][choice - 1]
                                                  }.from('-').to(circle)
      end
    end
  end

  describe '#confirm_col' do
    context 'when column number is valid' do
      it "doesn't output an invalid number error" do
        choice = 4
        invalid_error = 'Error: Only enter a valid column number [1-7]'
        expect(grid).not_to receive(:puts).with(invalid_error)
        grid.confirm_col(choice)
      end
    end
    context 'when column number is invalid thrice, then valid' do
      it 'outputs an invalid number error thrice' do
        choice = 150
        invalid_error = 'Error: Only enter a valid column number [1-7]'
        allow(grid).to receive_message_chain(:gets, :chomp).and_return('one',
                                                                       'two', 3)
        expect(grid).to receive(:puts).with(invalid_error).thrice
        grid.confirm_col(choice)
      end
    end
    context 'when chosen column is valid, but full' do
      it 'outputs full column error once' do
        choice1 = 2
        choice2 = 1
        full_error = 'Error: Column full, choose another [1-7]'
        grid.positions.map { |row| row[choice1 - 1] = '●' }
        allow(grid).to receive_message_chain(:gets, :chomp).and_return(choice2)
        expect(grid).to receive(:puts).with(full_error).once
        grid.confirm_col(choice1)
      end
    end
  end

  describe '#full?' do
    context "when all of the positions include '-'" do
      it 'returns false' do
        expect(grid.full?).to eq(false)
      end
    end
    context "when none of the positions include '-'" do
      it 'returns true' do
        grid.positions = Array.new(6) { Array.new(7, '○') }.reverse
        expect(grid.full?).to eq(true)
      end
    end
  end
end
