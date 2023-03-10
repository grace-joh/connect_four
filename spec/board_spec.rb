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

  describe '#create_rows' do
    it 'creates an array of row arrays' do
      board = Board.new

      expect(board.create_rows).to be_an(Array)
      expect(board.create_rows).to all(be_an(Array))
      expect(board.create_rows.flatten).to all(eq('*'))
    end
  end

  describe '#print_layout' do
    it 'prints an empty board' do
      board = Board.new

      expect { board.print_layout }.to output("A B C D E F G\n* * * * * * *\n* * * * * * *\n* * * * * * *\n* * * * * * *\n* * * * * * *\n* * * * * * *\n").to_stdout
    end
  end

  describe '#column_free?' do
    it 'checks if column has available spaces' do
      board = Board.new
      computer = Computer.new('O')
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
      board.layout[:A] = ['X', 'O', '*', '*', '*', '*']

      expect(board.full?).to eq(false)
    end

    it 'returns true if board is filled with symbols' do
      board = Board.new
      board.layout[:A] = ['X', 'O', 'X', 'O', 'X', 'O']
      board.layout[:B] = ['O', 'X', 'O', 'X', 'O', 'X']
      board.layout[:C] = ['X', 'O', 'X', 'O', 'X', 'O']
      board.layout[:D] = ['O', 'X', 'O', 'X', 'O', 'X']
      board.layout[:E] = ['X', 'O', 'X', 'O', 'X', 'O']
      board.layout[:F] = ['O', 'X', 'O', 'X', 'O', 'X']
      board.layout[:G] = ['X', 'O', 'X', 'O', 'X', 'O']

      expect(board.full?).to eq(true)
    end
  end

  describe '#reset' do
    it 'resets a board that has been played on' do
      board = Board.new
      board.layout[:A] = ['X', 'X', 'X', 'O', '*', '*']
      board.layout[:B] = ['X', 'X', 'O', '*', '*', '*']
      board.layout[:C] = ['O', 'O', '*', '*', '*', '*']
      board.layout[:D] = ['O', 'O', '*', '*', '*', '*']
      board.layout[:E] = ['X', 'X', 'O', '*', '*', '*']
      board.layout[:F] = ['O', 'O', 'X', '*', '*', '*']
      board.layout[:G] = ['X', 'X', 'O', '*', '*', '*']
      board.reset

      expect(board.layout.values.flatten).to all(eq('*'))
    end
  end
end
