require 'spec_helper'

RSpec.describe Game do
  before(:each) do
    @game = Game.new
  end

  describe '#initialize' do
    it 'exists' do
      expect(@game).to be_a(Game)
      expect(@game.player1).to be_a(Player)
      expect(@game.player2).to be_a(Computer)
      expect(@game.turn).to be_a(Turn)
      expect(@game.winner).to be_nil
    end
  end

  describe '#players' do
    it 'returns an array of both players' do
      expect(@game.players).to eq([@game.player1, @game.player2])
      expect(@game.players.first).to be_a(Player)
      expect(@game.players.last).to be_a(Computer)
    end
  end

  describe '#output_goodbye' do
    it 'says bye' do
      expect { @game.output_goodbye }.to output('Bye!').to_stdout
    end
  end

  describe '#output_welcome' do
    it 'says welcome and prints an empty board' do
      expect { @game.output_welcome }.to output("Welcome to Connect 4!\n\nA B C D E F G\n* * * * * * *\n* * * * * * *\n* * * * * * *\n* * * * * * *\n* * * * * * *\n* * * * * * *\n").to_stdout
    end
  end

  describe '#output_turn' do
    it 'alerts the user that it is their' do
      expect { @game.output_turn(@game.players.first) }.to output("\nIt's your turn.\nChoose a column from A to G\n").to_stdout
    end

    it 'alerts the user that it is the computers turn' do
      expect { @game.output_turn(@game.players.last) }.to output("\nIt's the computer's turn.\n").to_stdout
    end
  end

  describe '#output_winner' do
    it 'alerts the user if they win' do
      @game.winner = @game.players.first

      expect { @game.output_winner }.to output("You win!!!\n").to_stdout
    end

    it 'alerts the user if they lose' do
      @game.winner = @game.players.last

      expect { @game.output_winner }.to output("You lose :(\n").to_stdout
    end

    it 'alerts the user if the game ends with no winner' do
      @game.winner = nil

      expect { @game.output_winner }.to output("This game was a draw.\n").to_stdout
    end
  end

  describe '#output_play_again' do
    it 'ask the user if they want to play again' do
      expect { @game.output_play_again }.to output("Play again?\n").to_stdout
    end
  end

  describe '#win?' do
    it 'returns false if on a new board' do
      expect(@game.win?('X')).to eq(false)
      expect(@game.win?('O')).to eq(false)
    end

    it 'returns false if board is full with no wins' do
      @game.turn.board.layout[:A] = ['X', 'O', 'X', 'X', 'X', 'O']
      @game.turn.board.layout[:B] = ['O', 'X', 'O', 'X', 'O', 'X']
      @game.turn.board.layout[:C] = ['X', 'O', 'O', 'O', 'X', 'O']
      @game.turn.board.layout[:D] = ['X', 'O', 'X', 'O', 'X', 'O']
      @game.turn.board.layout[:E] = ['X', 'O', 'X', 'O', 'X', 'O']
      @game.turn.board.layout[:F] = ['O', 'X', 'O', 'X', 'O', 'X']
      @game.turn.board.layout[:G] = ['X', 'O', 'X', 'O', 'X', 'O']

      expect(@game.win?('X')).to eq(false)
      expect(@game.win?('O')).to eq(false)
    end

    it 'returns true if player wins with vertical' do
      @game.turn.board.layout[:A] = ['*', '*', '*', '*', '*', '*']
      @game.turn.board.layout[:B] = ['*', '*', '*', '*', '*', '*']
      @game.turn.board.layout[:C] = ['*', '*', '*', '*', '*', '*']
      @game.turn.board.layout[:D] = ['*', '*', '*', '*', '*', '*']
      @game.turn.board.layout[:E] = ['*', '*', '*', '*', '*', '*']
      @game.turn.board.layout[:F] = ['O', 'O', 'O', '*', '*', '*']
      @game.turn.board.layout[:G] = ['X', 'X', 'X', 'X', '*', '*']

      expect(@game.win?('X')).to eq(true)
      expect(@game.win?('O')).to eq(false)
    end

    it 'returns true if computer wins with vertical' do
      @game.turn.board.layout[:A] = ['X', '*', '*', '*', '*', '*']
      @game.turn.board.layout[:B] = ['O', 'O', 'O', 'O', '*', '*']
      @game.turn.board.layout[:C] = ['X', '*', '*', '*', '*', '*']
      @game.turn.board.layout[:D] = ['X', '*', '*', '*', '*', '*']
      @game.turn.board.layout[:E] = ['X', '*', '*', '*', '*', '*']
      @game.turn.board.layout[:F] = ['*', '*', '*', '*', '*', '*']
      @game.turn.board.layout[:G] = ['*', '*', '*', '*', '*', '*']

      expect(@game.win?('O')).to eq(true)
      expect(@game.win?('X')).to eq(false)
    end

    it 'returns true if player wins with horizontal' do
      @game.turn.board.layout[:A] = ['O', 'O', '*', '*', '*', '*']
      @game.turn.board.layout[:B] = ['X', 'O', '*', '*', '*', '*']
      @game.turn.board.layout[:C] = ['O', 'O', '*', '*', '*', '*']
      @game.turn.board.layout[:D] = ['O', 'X', 'X', '*', '*', '*']
      @game.turn.board.layout[:E] = ['X', 'X', '*', '*', '*', '*']
      @game.turn.board.layout[:F] = ['X', 'X', 'O', '*', '*', '*']
      @game.turn.board.layout[:G] = ['O', 'X', '*', '*', '*', '*']

      expect(@game.win?('X')).to eq(true)
      expect(@game.win?('O')).to eq(false)
    end

    it 'returns true if computer wins with horizontal' do
      @game.turn.board.layout[:A] = ['O', 'O', '*', '*', '*', '*']
      @game.turn.board.layout[:B] = ['X', 'O', '*', '*', '*', '*']
      @game.turn.board.layout[:C] = ['O', 'O', '*', '*', '*', '*']
      @game.turn.board.layout[:D] = ['O', 'O', 'X', '*', '*', '*']
      @game.turn.board.layout[:E] = ['X', 'X', '*', '*', '*', '*']
      @game.turn.board.layout[:F] = ['X', 'X', 'X', '*', '*', '*']
      @game.turn.board.layout[:G] = ['O', 'X', '*', '*', '*', '*']

      expect(@game.win?('O')).to eq(true)
      expect(@game.win?('X')).to eq(false)
    end

    it 'returns true if player wins diagonally' do
      @game.turn.board.layout[:A] = ['O', '*', '*', '*', '*', '*']
      @game.turn.board.layout[:B] = ['O', '*', '*', '*', '*', '*']
      @game.turn.board.layout[:C] = ['O', '*', '*', '*', '*', '*']
      @game.turn.board.layout[:D] = ['X', '*', '*', '*', '*', '*']
      @game.turn.board.layout[:E] = ['X', 'X', '*', '*', '*', '*']
      @game.turn.board.layout[:F] = ['O', 'O', 'X', '*', '*', '*']
      @game.turn.board.layout[:G] = ['X', 'X', 'O', 'X', '*', '*']

      expect(@game.win?('X')).to eq(true)
      expect(@game.win?('O')).to eq(false)
    end

    it 'returns true if computer wins diagonally' do
      @game.turn.board.layout[:A] = ['X', 'X', 'X', 'O', '*', '*']
      @game.turn.board.layout[:B] = ['X', 'X', 'O', '*', '*', '*']
      @game.turn.board.layout[:C] = ['O', 'O', '*', '*', '*', '*']
      @game.turn.board.layout[:D] = ['O', 'O', '*', '*', '*', '*']
      @game.turn.board.layout[:E] = ['X', 'X', 'O', '*', '*', '*']
      @game.turn.board.layout[:F] = ['O', 'O', 'X', '*', '*', '*']
      @game.turn.board.layout[:G] = ['X', 'X', 'O', '*', '*', '*']

      expect(@game.win?('O')).to eq(true)
      expect(@game.win?('X')).to eq(false)
    end
  end

  describe '#vertical_win?' do
    it 'returns true if column has four consecutive X symbols' do
      @game.turn.board.layout[:A] = ['*', '*', '*', '*', '*', '*']
      @game.turn.board.layout[:B] = ['*', '*', '*', '*', '*', '*']
      @game.turn.board.layout[:C] = ['*', '*', '*', '*', '*', '*']
      @game.turn.board.layout[:D] = ['*', '*', '*', '*', '*', '*']
      @game.turn.board.layout[:E] = ['*', '*', '*', '*', '*', '*']
      @game.turn.board.layout[:F] = ['*', '*', '*', '*', '*', '*']
      @game.turn.board.layout[:G] = ['X', 'X', 'X', 'X', '*', '*']

      expect(@game.vertical_win?('X')).to eq(true)
      expect(@game.vertical_win?('O')).to eq(false)
    end

    it 'returns false if column does not have four X symbols' do
      @game.turn.board.layout[:A] = ['X', 'O', 'X', 'O', 'X', 'O']
      @game.turn.board.layout[:B] = ['X', 'X', 'O', 'X', 'O', 'X']
      @game.turn.board.layout[:C] = ['X', 'O', 'O', 'O', 'X', 'O']
      @game.turn.board.layout[:D] = ['O', 'X', 'O', 'X', 'O', 'X']
      @game.turn.board.layout[:E] = ['O', 'O', 'X', 'O', 'X', 'O']
      @game.turn.board.layout[:F] = ['O', 'X', 'O', 'X', 'O', 'X']
      @game.turn.board.layout[:G] = ['X', 'X', 'X', 'O', 'X', 'O']

      expect(@game.vertical_win?('X')).to eq(false)
      expect(@game.vertical_win?('O')).to eq(false)
    end

    it 'returns true if column has four consecutive O symbols' do
      @game.turn.board.layout[:A] = ['*', '*', '*', '*', '*', '*']
      @game.turn.board.layout[:B] = ['*', '*', '*', '*', '*', '*']
      @game.turn.board.layout[:C] = ['*', '*', '*', '*', '*', '*']
      @game.turn.board.layout[:D] = ['*', '*', '*', '*', '*', '*']
      @game.turn.board.layout[:E] = ['*', '*', '*', '*', '*', '*']
      @game.turn.board.layout[:F] = ['*', '*', '*', '*', '*', '*']
      @game.turn.board.layout[:G] = ['O', 'O', 'O', 'O', '*', '*']

      expect(@game.vertical_win?('O')).to eq(true)
      expect(@game.vertical_win?('X')).to eq(false)
    end

    it 'returns false if column does not have four consecutive O symbols' do
      @game.turn.board.layout[:A] = ['X', 'O', 'X', 'X', 'X', 'X']
      @game.turn.board.layout[:B] = ['O', 'O', 'O', 'X', 'O', 'X']
      @game.turn.board.layout[:C] = ['X', 'O', 'X', 'O', 'X', 'O']
      @game.turn.board.layout[:D] = ['O', 'X', 'O', 'X', 'O', 'X']
      @game.turn.board.layout[:E] = ['X', 'O', 'X', 'O', 'X', 'O']
      @game.turn.board.layout[:F] = ['O', 'X', 'O', 'X', 'O', 'X']
      @game.turn.board.layout[:G] = ['X', 'O', 'X', 'O', 'X', 'O']

      expect(@game.vertical_win?('O')).to eq(false)
      expect(@game.vertical_win?('X')).to eq(true)
    end
  end

  describe '#horizontal_win?' do
    it 'returns true if row has four consecutive X symbols' do
      @game.turn.board.layout[:A] = ['O', '*', '*', '*', '*', '*']
      @game.turn.board.layout[:B] = ['O', '*', '*', '*', '*', '*']
      @game.turn.board.layout[:C] = ['O', '*', '*', '*', '*', '*']
      @game.turn.board.layout[:D] = ['X', 'O', '*', '*', '*', '*']
      @game.turn.board.layout[:E] = ['X', '*', '*', '*', '*', '*']
      @game.turn.board.layout[:F] = ['X', 'O', '*', '*', '*', '*']
      @game.turn.board.layout[:G] = ['X', 'X', 'X', '*', '*', '*']

      expect(@game.horizontal_win?('X')).to eq(true)
      expect(@game.horizontal_win?('O')).to eq(false)
    end

    it 'returns false if row does not have four X symbols' do
      @game.turn.board.layout[:A] = ['X', 'O', 'O', 'O', 'X', '*']
      @game.turn.board.layout[:B] = ['X', 'X', 'O', 'X', 'O', '*']
      @game.turn.board.layout[:C] = ['X', 'O', 'O', 'O', 'X', '*']
      @game.turn.board.layout[:D] = ['O', 'X', 'O', 'X', 'O', '*']
      @game.turn.board.layout[:E] = ['X', 'O', 'X', 'O', 'X', '*']
      @game.turn.board.layout[:F] = ['X', 'X', 'O', 'X', 'O', '*']
      @game.turn.board.layout[:G] = ['X', 'X', 'X', 'X', 'X', '*']

      expect(@game.horizontal_win?('X')).to eq(false)
      expect(@game.horizontal_win?('O')).to eq(true)
    end

    it 'returns true if row has four consecutive O symbols' do
      @game.turn.board.layout[:A] = ['O', 'O', '*', '*', '*', '*']
      @game.turn.board.layout[:B] = ['X', 'O', '*', '*', '*', '*']
      @game.turn.board.layout[:C] = ['O', 'O', '*', '*', '*', '*']
      @game.turn.board.layout[:D] = ['O', 'O', 'X', '*', '*', '*']
      @game.turn.board.layout[:E] = ['X', 'X', '*', '*', '*', '*']
      @game.turn.board.layout[:F] = ['X', 'X', 'X', '*', '*', '*']
      @game.turn.board.layout[:G] = ['O', 'X', '*', '*', '*', '*']

      expect(@game.horizontal_win?('O')).to eq(true)
      expect(@game.horizontal_win?('X')).to eq(false)
    end

    it 'returns false if row does not have four consecutive O symbols' do
      @game.turn.board.layout[:A] = ['O', 'O', 'X', 'O', 'X', 'O']
      @game.turn.board.layout[:B] = ['X', 'X', 'O', 'X', 'O', 'X']
      @game.turn.board.layout[:C] = ['X', 'O', 'X', 'O', 'X', 'O']
      @game.turn.board.layout[:D] = ['X', 'X', 'O', 'X', 'O', 'X']
      @game.turn.board.layout[:E] = ['X', 'O', 'X', 'O', 'X', 'O']
      @game.turn.board.layout[:F] = ['O', 'X', 'O', 'X', 'O', 'X']
      @game.turn.board.layout[:G] = ['X', 'O', 'X', 'O', 'X', 'O']

      expect(@game.horizontal_win?('O')).to eq(false)
      expect(@game.horizontal_win?('X')).to eq(true)
    end
  end

  describe '#diagonal_win?' do
    it 'returns false if there is no diagonally consecutive symbols' do
      @game.turn.board.layout[:A] = ['O', '*', '*', '*', '*', '*']
      @game.turn.board.layout[:B] = ['O', '*', '*', '*', '*', '*']
      @game.turn.board.layout[:C] = ['O', '*', '*', '*', '*', '*']
      @game.turn.board.layout[:D] = ['X', 'O', '*', '*', '*', '*']
      @game.turn.board.layout[:E] = ['X', '*', '*', '*', '*', '*']
      @game.turn.board.layout[:F] = ['O', 'O', '*', '*', '*', '*']
      @game.turn.board.layout[:G] = ['X', 'X', 'X', '*', '*', '*']

      expect(@game.diagonal_win?('X')).to eq(false)
      expect(@game.diagonal_win?('O')).to eq(false)
    end

    it 'returns true if there are upward diagonally consecutive player symbols' do

      @game.turn.board.layout[:A] = ['O', '*', '*', '*', '*', '*']
      @game.turn.board.layout[:B] = ['O', '*', '*', '*', '*', '*']
      @game.turn.board.layout[:C] = ['O', '*', '*', '*', '*', '*']
      @game.turn.board.layout[:D] = ['X', '*', '*', '*', '*', '*']
      @game.turn.board.layout[:E] = ['X', 'X', '*', '*', '*', '*']
      @game.turn.board.layout[:F] = ['O', 'O', 'X', '*', '*', '*']
      @game.turn.board.layout[:G] = ['X', 'X', 'O', 'X', '*', '*']

      expect(@game.diagonal_win?('X')).to eq(true)
      expect(@game.diagonal_win?('O')).to eq(false)
    end

    it 'returns true if there are downard diagonally consecutive player symbols' do

      @game.turn.board.layout[:A] = ['X', 'O', '*', '*', '*', '*']
      @game.turn.board.layout[:B] = ['X', 'X', 'O', 'X', '*', '*']
      @game.turn.board.layout[:C] = ['O', 'O', 'X', '*', '*', '*']
      @game.turn.board.layout[:D] = ['O', 'X', '*', '*', '*', '*']
      @game.turn.board.layout[:E] = ['X', 'X', '*', '*', '*', '*']
      @game.turn.board.layout[:F] = ['O', 'O', 'O', '*', '*', '*']
      @game.turn.board.layout[:G] = ['X', 'O', '*', '*', '*', '*']

      expect(@game.diagonal_win?('X')).to eq(true)
      expect(@game.diagonal_win?('O')).to eq(false)
    end    

    it 'returns true if there are upward diagonally consecutive computer symbols' do

      @game.turn.board.layout[:A] = ['O', 'X', '*', '*', '*', '*']
      @game.turn.board.layout[:B] = ['O', 'X', '*', '*', '*', '*']
      @game.turn.board.layout[:C] = ['O', 'O', '*', '*', '*', '*']
      @game.turn.board.layout[:D] = ['X', 'O', '*', '*', '*', '*']
      @game.turn.board.layout[:E] = ['X', 'X', 'O', '*', '*', '*']
      @game.turn.board.layout[:F] = ['O', 'X', 'O', 'O', '*', '*']
      @game.turn.board.layout[:G] = ['X', 'X', 'X', '*', '*', '*']

      expect(@game.diagonal_win?('O')).to eq(true)
      expect(@game.diagonal_win?('X')).to eq(false)
    end

    it 'returns true if there are downward diagonally consecutive computer symbols' do

      @game.turn.board.layout[:A] = ['X', 'X', 'X', 'O', '*', '*']
      @game.turn.board.layout[:B] = ['X', 'X', 'O', '*', '*', '*']
      @game.turn.board.layout[:C] = ['O', 'O', '*', '*', '*', '*']
      @game.turn.board.layout[:D] = ['O', 'O', '*', '*', '*', '*']
      @game.turn.board.layout[:E] = ['X', 'X', 'O', '*', '*', '*']
      @game.turn.board.layout[:F] = ['O', 'O', 'X', '*', '*', '*']
      @game.turn.board.layout[:G] = ['X', 'X', 'O', '*', '*', '*']

      expect(@game.diagonal_win?('O')).to eq(true)
      expect(@game.diagonal_win?('X')).to eq(false)
    end
  end

  describe '#create_diagonals_of_four' do
    it 'builds an array of arrays of all four consecutive diagonal spaces' do
      @game.turn.board.layout[:A] = ['a0','a1','a2','a3','a4','a5']
      @game.turn.board.layout[:B] = ['b0','b1','b2','b3','b4','b5']
      @game.turn.board.layout[:C] = ['c0','c1','c2','c3','c4','c5']
      @game.turn.board.layout[:D] = ['d0','d1','d2','d3','d4','d5']
      @game.turn.board.layout[:E] = ['e0','e1','e2','e3','e4','e5']
      @game.turn.board.layout[:F] = ['f0','f1','f2','f3','f4','f5']
      @game.turn.board.layout[:G] = ['g0','g1','g2','g3','g4','g5']

      expect(@game.create_diagonals_of_four).to be_an(Array)
      expect(@game.create_diagonals_of_four).to all(be_an(Array))
      expect(@game.create_diagonals_of_four).to eq([["a0", "b1", "c2", "d3"], ["a3", "b2", "c1", "d0"], 
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
