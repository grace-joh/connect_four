require 'spec_helper'

RSpec.describe Board do
  describe '#initialize' do
    it 'exists' do
      board = Board.new

      expect(board).to be_a(Board)
      expect(board.layout).to be_a(Hash)
      expect(board.layout.values).to all(be_an(Array))
      expect(board.layout.values.flatten.count('*')).to eq(42)
    end
  end

  describe '#print' do
    it 'prints an empty board' do
      board = Board.new

      expect { board.print_layout }.to output("A B C D E F G\n* * * * * * *\n* * * * * * *\n* * * * * * *\n* * * * * * *\n* * * * * * *\n* * * * * * *\n").to_stdout
    end
  end

  describe '#column_free?' do
    it 'checks if column has available spaces' do
      board = Board.new
      computer = Computer.new
      input = computer.input

      expect(board.column_free?(input)).to eq(true)
      expect(board.column_free?(:A)).to eq(true)
      expect(board.column_free?(:B)).to eq(true)
      expect(board.column_free?(:C)).to eq(true)
      expect(board.column_free?(:D)).to eq(true)
      expect(board.column_free?(:E)).to eq(true)
      expect(board.column_free?(:F)).to eq(true)
      expect(board.column_free?(:G)).to eq(true)
    end

    it 'returns false if column is full' do
      board = Board.new
      board.layout[:A] = ['X','X','X','X','X','X']
      board.layout[:B] = ['O','X','O','X','O','X']
      board.layout[:C] = ['O','X','O','X','O','*']

      expect(board.column_free?(:A)).to eq(false)
      expect(board.column_free?(:B)).to eq(false)
      expect(board.column_free?(:C)).to eq(true)
    end
  end

  describe '#full?' do
    it 'returns false if on a new Board' do
      board = Board.new

      expect(board.full?).to eq(false)
    end

    it 'returns false if board is not full after move' do
      board = Board.new
      # refactor below later
      board.layout[:A] = ['X','O','*','*','*','*']

      expect(board.full?).to eq(false)
    end

    it 'returns true if board is filled with symbols' do
      board = Board.new
      # refactor below later
      board.layout[:A] = ['X','O','X','O','X','O'],
      board.layout[:B] = ['O','X','O','X','O','X'],
      board.layout[:C] = ['X','O','X','O','X','O'],
      board.layout[:D] = ['O','X','O','X','O','X'],
      board.layout[:E] = ['X','O','X','O','X','O'],
      board.layout[:F] = ['O','X','O','X','O','X'],
      board.layout[:G] = ['X','O','X','O','X','O']

      expect(board.full?).to eq(true)
    end
  end

  describe '#vertical_win?' do
    it 'returns true if column has four consecutive X symbols' do
      board = Board.new
      # refactor below later
      board.layout[:A] = ['*','*','*','*','*','*'],
      board.layout[:B] = ['*','*','*','*','*','*'],
      board.layout[:C] = ['*','*','*','*','*','*'],
      board.layout[:D] = ['*','*','*','*','*','*'],
      board.layout[:E] = ['*','*','*','*','*','*'],
      board.layout[:F] = ['*','*','*','*','*','*'],
      board.layout[:G] = ['X','X','X','X','*','*']

      expect(board.vertical_win?('X')).to eq(true)
    end

    it 'returns false if column does not have four X symbols' do
      board = Board.new
      # refactor below later
      board.layout[:A] = ['X','O','X','O','X','O'],
      board.layout[:B] = ['O','X','O','X','O','X'],
      board.layout[:C] = ['X','O','X','O','X','O'],
      board.layout[:D] = ['O','X','O','X','O','X'],
      board.layout[:E] = ['X','O','X','O','X','O'],
      board.layout[:F] = ['O','X','O','X','O','X'],
      board.layout[:G] = ['X','O','X','O','X','O']

      expect(board.vertical_win?('X')).to eq(false)
    end

    it 'returns true if column has four consecutive O symbols' do
      board = Board.new
      # refactor below later
      board.layout[:A] = ['*','*','*','*','*','*'],
      board.layout[:B] = ['*','*','*','*','*','*'],
      board.layout[:C] = ['*','*','*','*','*','*'],
      board.layout[:D] = ['*','*','*','*','*','*'],
      board.layout[:E] = ['*','*','*','*','*','*'],
      board.layout[:F] = ['*','*','*','*','*','*'],
      board.layout[:G] = ['O','O','O','O','*','*']

      expect(board.vertical_win?('O')).to eq(true)
    end

    it 'returns false if column does not have four consecutive O symbols' do
      board = Board.new
      # refactor below later
      board.layout[:A] = ['X','O','X','O','X','O'],
      board.layout[:B] = ['O','X','O','X','O','X'],
      board.layout[:C] = ['X','O','X','O','X','O'],
      board.layout[:D] = ['O','X','O','X','O','X'],
      board.layout[:E] = ['X','O','X','O','X','O'],
      board.layout[:F] = ['O','X','O','X','O','X'],
      board.layout[:G] = ['X','O','X','O','X','O']

      expect(board.vertical_win?('O')).to eq(false)
    end
  end
end
