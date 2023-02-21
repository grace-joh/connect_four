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

  describe '#rows' do
    it 'creates an array of row arrays' do
      board = Board.new

      expect(board.rows).to be_an(Array)
      expect(board.rows).to all(be_an(Array))
      expect(board.rows.flatten).to all(eq('*'))
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
      board.layout[:A] = ['*','*','*','*','*','*']
      board.layout[:B] = ['*','*','*','*','*','*']
      board.layout[:C] = ['*','*','*','*','*','*']
      board.layout[:D] = ['*','*','*','*','*','*']
      board.layout[:E] = ['*','*','*','*','*','*']
      board.layout[:F] = ['*','*','*','*','*','*']
      board.layout[:G] = ['X','X','X','X','*','*']

      expect(board.vertical_win?('X')).to eq(true)
    end

    it 'returns false if column does not have four X symbols' do
      board = Board.new
      # refactor below later
      board.layout[:A] = ['X','O','X','O','X','O']
      board.layout[:B] = ['O','X','O','X','O','X']
      board.layout[:C] = ['X','O','X','O','X','O']
      board.layout[:D] = ['O','X','O','X','O','X']
      board.layout[:E] = ['X','O','X','O','X','O']
      board.layout[:F] = ['O','X','O','X','O','X']
      board.layout[:G] = ['X','O','X','O','X','O']

      expect(board.vertical_win?('X')).to eq(false)
    end

    it 'returns true if column has four consecutive O symbols' do
      board = Board.new
      # refactor below later
      board.layout[:A] = ['*','*','*','*','*','*']
      board.layout[:B] = ['*','*','*','*','*','*']
      board.layout[:C] = ['*','*','*','*','*','*']
      board.layout[:D] = ['*','*','*','*','*','*']
      board.layout[:E] = ['*','*','*','*','*','*']
      board.layout[:F] = ['*','*','*','*','*','*']
      board.layout[:G] = ['O','O','O','O','*','*']

      expect(board.vertical_win?('O')).to eq(true)
    end

    it 'returns false if column does not have four consecutive O symbols' do
      board = Board.new
      # refactor below later
      board.layout[:A] = ['X','O','X','O','X','O']
      board.layout[:B] = ['O','X','O','X','O','X']
      board.layout[:C] = ['X','O','X','O','X','O']
      board.layout[:D] = ['O','X','O','X','O','X']
      board.layout[:E] = ['X','O','X','O','X','O']
      board.layout[:F] = ['O','X','O','X','O','X']
      board.layout[:G] = ['X','O','X','O','X','O']

      expect(board.vertical_win?('O')).to eq(false)
    end
  end

  describe '#horizontal_win?' do
    it 'returns true if row has four consecutive X symbols' do
      board = Board.new
      # refactor below later
      board.layout[:A] = ['O', '*', '*', '*', '*', '*']
      board.layout[:B] = ['O', '*', '*', '*', '*', '*']
      board.layout[:C] = ['O', '*', '*', '*', '*', '*']
      board.layout[:D] = ['X', 'O', '*', '*', '*', '*']
      board.layout[:E] = ['X', '*', '*', '*', '*', '*']
      board.layout[:F] = ['X', 'O', '*', '*', '*', '*']
      board.layout[:G] = ['X', 'X', 'X', '*', '*', '*']

      expect(board.horizontal_win?('X')).to eq(true)
    end

    it 'returns false if row does not have four X symbols' do
      board = Board.new
      # refactor below later
      board.layout[:A] = ['X', 'O', 'X', 'O', 'X', '*']
      board.layout[:B] = ['O', 'X', 'O', 'X', 'O', '*']
      board.layout[:C] = ['X', 'O', 'X', 'O', 'X', '*']
      board.layout[:D] = ['O', 'X', 'O', 'X', 'O', '*']
      board.layout[:E] = ['X', 'O', 'X', 'O', 'X', '*']
      board.layout[:F] = ['O', 'X', 'O', 'X', 'O', '*']
      board.layout[:G] = ['X', 'O', 'X', 'O', 'X', '*']

      expect(board.horizontal_win?('X')).to eq(false)
    end

    it 'returns true if row has four consecutive O symbols' do
      board = Board.new
      # refactor below later
      board.layout[:A] = ['O', 'O', '*', '*', '*', '*']
      board.layout[:B] = ['X', 'O', '*', '*', '*', '*']
      board.layout[:C] = ['O', 'O', '*', '*', '*', '*']
      board.layout[:D] = ['O', 'O', 'X', '*', '*', '*']
      board.layout[:E] = ['X', 'X', '*', '*', '*', '*']
      board.layout[:F] = ['X', 'X', 'X', '*', '*', '*']
      board.layout[:G] = ['O', 'X', '*', '*', '*', '*']

      expect(board.horizontal_win?('O')).to eq(true)
    end

    it 'returns false if row does not have four consecutive O symbols' do
      board = Board.new
      # refactor below later
      board.layout[:A] = ['X', 'O', 'X', 'O', 'X', 'O']
      board.layout[:B] = ['O', 'X', 'O', 'X', 'O', 'X']
      board.layout[:C] = ['X', 'O', 'X', 'O', 'X', 'O']
      board.layout[:D] = ['O', 'X', 'O', 'X', 'O', 'X']
      board.layout[:E] = ['X', 'O', 'X', 'O', 'X', 'O']
      board.layout[:F] = ['O', 'X', 'O', 'X', 'O', 'X']
      board.layout[:G] = ['X', 'O', 'X', 'O', 'X', 'O']

      expect(board.horizontal_win?('O')).to eq(false)
    end
  end

  describe '#diagonal_win?' do
    it 'returns false if there is no diagonally consecutive symbols' do
      board = Board.new
      # refactor below later
      board.layout[:A] = ['O', '*', '*', '*', '*', '*']
      board.layout[:B] = ['O', '*', '*', '*', '*', '*']
      board.layout[:C] = ['O', '*', '*', '*', '*', '*']
      board.layout[:D] = ['X', 'O', '*', '*', '*', '*']
      board.layout[:E] = ['X', '*', '*', '*', '*', '*']
      board.layout[:F] = ['O', 'O', '*', '*', '*', '*']
      board.layout[:G] = ['X', 'X', 'X', '*', '*', '*']

      expect(board.diagonal_win?('X')).to eq(false)
      expect(board.diagonal_win?('O')).to eq(false)
    end

    it 'returns true if there are upward diagonally consecutive player symbols' do
      board = Board.new

      board.layout[:A] = ['O', '*', '*', '*', '*', '*']
      board.layout[:B] = ['O', '*', '*', '*', '*', '*']
      board.layout[:C] = ['O', '*', '*', '*', '*', '*']
      board.layout[:D] = ['X', '*', '*', '*', '*', '*']
      board.layout[:E] = ['X', 'X', '*', '*', '*', '*']
      board.layout[:F] = ['O', 'O', 'X', '*', '*', '*']
      board.layout[:G] = ['X', 'X', 'O', 'X', '*', '*']

      expect(board.diagonal_win?('X')).to eq(true)
    end

    it 'returns true if there are downard diagonally consecutive player symbols' do
      board = Board.new

      board.layout[:A] = ['X', 'O', '*', '*', '*', '*']
      board.layout[:B] = ['X', 'X', 'O', 'X', '*', '*']
      board.layout[:C] = ['O', 'O', 'X', '*', '*', '*']
      board.layout[:D] = ['O', 'X', '*', '*', '*', '*']
      board.layout[:E] = ['X', 'X', '*', '*', '*', '*']
      board.layout[:F] = ['O', 'O', 'O', '*', '*', '*']
      board.layout[:G] = ['X', 'O', '*', '*', '*', '*']

      expect(board.diagonal_down_win?('X')).to eq(true)
    end    

    it 'returns true if there are upward diagonally consecutive computer symbols' do
      board = Board.new

      board.layout[:A] = ['O', 'X', '*', '*', '*', '*']
      board.layout[:B] = ['O', 'X', '*', '*', '*', '*']
      board.layout[:C] = ['O', 'O', '*', '*', '*', '*']
      board.layout[:D] = ['X', 'O', '*', '*', '*', '*']
      board.layout[:E] = ['X', 'X', 'O', '*', '*', '*']
      board.layout[:F] = ['O', 'X', 'O', 'O', '*', '*']
      board.layout[:G] = ['X', 'X', 'X', '*', '*', '*']

      expect(board.diagonal_win?('O')).to eq(true)
    end

    it 'returns true if there are downward diagonally consecutive computer symbols' do
      board = Board.new

      board.layout[:A] = ['X', 'X', 'X', 'O', '*', '*']
      board.layout[:B] = ['X', 'X', 'O', '*', '*', '*']
      board.layout[:C] = ['O', 'O', '*', '*', '*', '*']
      board.layout[:D] = ['O', 'O', '*', '*', '*', '*']
      board.layout[:E] = ['X', 'X', 'O', '*', '*', '*']
      board.layout[:F] = ['O', 'O', 'X', '*', '*', '*']
      board.layout[:G] = ['X', 'X', 'O', '*', '*', '*']

      expect(board.diagonal_win?('O')).to eq(true)
    end
  end

  describe '#diagonal_arrays' do
    it 'builds an array of arrays of all four consecutive diagonal spaces' do
      board = Board.new
      board.layout[:A] = ['a0', 'a1','a2','a3','a4','a5'],
      board.layout[:B] = ['b0', 'b1','b2','b3','b4','b5'],
      board.layout[:C] = ['c0', 'c1','c2','c3','c4','c5'],
      board.layout[:D] = ['d0', 'd1','d2','d3','d4','d5'],
      board.layout[:E] = ['e0', 'e1','e2','e3','e4','e5'],
      board.layout[:F] = ['f0', 'f1','f2','f3','f4','f5'],
      board.layout[:G] = ['g0', 'g1','g2','g3','g4','g5']
  
      expect(board.diagonal_up_arrays).to be_an(Array)
      expect(board.diagonal_up_arrays).to all(be_an(Array))
      expect(board.diagonal_up_arrays).to eq([["a0", "b1", "c2", "d3"], ["a3", "b2", "c1", "d0"], 
                                              ["b0", "c1", "d2", "e3"], ["b3", "c2", "d1", "e0"], 
                                              ["c0", "d1", "e2", "f3"], ["c3", "d2", "e1", "f0"], 
                                              ["d0", "e1", "f2", "g3"], ["d3", "e2", "f1", "g0"], 
                                              ["a1", "b2", "c3", "d4"], ["a4", "b3", "c2", "d1"], 
                                              ["b1", "c2", "d3", "e4"], ["b4", "c3", "d2", "e1"], 
                                              ["c1", "d2", "e3", "f4"], ["c4", "d3", "e2", "f1"], 
                                              ["d1", "e2", "f3", "g4"], ["d4", "e3", "f2", "g1"], 
                                              ["a2", "b3", "c4", "d5"], ["a5", "b4", "c3", "d2"], 
                                              ["b2", "c3", "d4", "e5"], ["b5", "c4", "d3", "e2"], 
                                              ["c2", "d3", "e4", "f5"], ["c5", "d4", "e3", "f2"], 
                                              ["d2", "e3", "f4", "g5"], ["d5", "e4", "f3", "g2"]])
    end
  end
end
