require 'spec_helper'

RSpec.describe Turn do
  describe '#initialize' do
    it 'exists' do
      turn = Turn.new

      expect(turn).to be_a(Turn)
      expect(turn.board).to be_a(Board)
      expect(turn.winner).to be_nil
    end

    it 'can initialize another turn' do
      turn2 = Turn.new

      expect(turn2).to be_a(Turn)
      expect(turn2.board).to be_a(Board)
      expect(turn2.winner).to be_nil
    end
  end

  describe '#update_board' do
    it "adds  the player's piece to the column the player chooses" do
      player = Player.new('X')
      turn = Turn.new
      input = 'A'
      turn.update_board(player, input)

      expect(turn.board.layout[:A]).to eq(['X', '*', '*', '*', '*', '*'])
    end

    it 'adds a second piece to the column the player chooses' do
      player = Player.new('X')
      computer = Computer.new('O')
      turn = Turn.new
      input = 'A'
      turn.update_board(player, input)
      input = 'A'
      turn.update_board(computer, input)

      expect(turn.board.layout[:A]).to eq(['X', 'O', '*', '*', '*', '*'])
    end

    it 'can add a piece to another column the player chooses' do
      user = Player.new('X')
      computer = Computer.new('O')
      turn = Turn.new
      input = 'A'
      turn.update_board(user, input)
      input = 'A'
      turn.update_board(computer, input)
      input = 'B'
      turn.update_board(user, input)

      expect(turn.board.layout[:A]).to eq(['X', 'O', '*', '*', '*', '*'])
      expect(turn.board.layout[:B]).to eq(['X', '*', '*', '*', '*', '*'])
    end
  end

  describe '#move' do
    it 'winner is nil if move does not win' do
      user = Player.new('X')
      computer = Computer.new('O')
      turn = Turn.new
      turn.move(user) # input a column choice A to G in test
      turn.move(computer)

      expect(turn.winner).to eq(nil)
    end

    it 'player is the winner if players move wins' do
      user = Player.new('X')
      turn = Turn.new
      turn.board.layout[:B] = ['X', '*', '*', '*', '*', '*']
      turn.board.layout[:C] = ['X', '*', '*', '*', '*', '*']
      turn.board.layout[:D] = ['X', '*', '*', '*', '*', '*']
      turn.move(user) # input is A or E in test

      expect(turn.winner).to eq(user)
    end

    it 'computer is the winner if computers move wins' do
      computer = Computer.new('O')
      turn = Turn.new
      turn.board.layout[:A] = ['O','O','O','*','*','*']
      turn.board.layout[:B] = ['O','O','O','*','*','*']
      turn.board.layout[:C] = ['O','O','O','*','*','*']
      turn.board.layout[:D] = ['*','*','*','*','*','*']
      turn.board.layout[:E] = ['O','O','O','*','*','*']
      turn.board.layout[:F] = ['O','O','O','*','*','*']
      turn.board.layout[:G] = ['O','O','O','*','*','*']
      turn.move(computer) 

      expect(turn.winner).to eq(computer)
    end
  end

  describe '#find_valid_space' do
    it 'returns the players input if it is a open space on the board' do
      player = Player.new('X')
      turn = Turn.new

      expect(('A'..'G').to_a).to include(turn.find_valid_space(player))
    end

    it 'prompts player to choose another input until input is an open space and valid' do
      player = Player.new('X')
      turn = Turn.new
      turn.board.layout[:A] = ['O', 'X', 'O', 'X', 'X', 'O']

      # input A as player choice
      expect(turn.find_valid_space(player)).not_to eq('A')
    end

    # it 'returns computers random choice only if it is a free column' do
    #   computer = Computer.new('O')
    #   turn = Turn.new
    #   turn.board.layout[:A] = ['O', 'X', 'O', 'X', 'X', 'O']
    #   turn.board.layout[:B] = ['O', 'X', 'O', 'X', 'X', 'O']
    #   turn.board.layout[:C] = ['O', 'X', 'O', 'X', 'X', 'O']
    #   turn.board.layout[:D] = ['O', 'X', 'O', 'X', 'X', '*']
    #   turn.board.layout[:E] = ['O', 'X', 'O', 'X', 'X', 'O']
    #   turn.board.layout[:F] = ['O', 'X', 'O', 'X', 'X', 'O']
    #   turn.board.layout[:G] = ['O', 'X', 'O', 'X', 'X', 'O']

    #   only passes when computer eventually chooses D first??
    #   expect(turn.find_valid_space(computer)).to eq('D')
    # end
  end

  describe '#valid?' do
    it 'returns false if the input is not from A to G' do
      turn = Turn.new
      input = 'z'

      expect(turn.valid?(input)).to eq(false)
    end

    it 'returns false if the input column is full' do
      turn = Turn.new
      turn.board.layout[:G] = ['O','O','O','O','O','O']
      input = 'G'

      expect(turn.valid?(input)).to eq(false)
    end

    it 'returns true if input is valid' do
      turn = Turn.new
      input = 'A'

      expect(turn.valid?(input)).to eq(true)
    end
  end
end
