require 'spec_helper'

RSpec.describe Turn do
  before(:each) do
    @board = Board.new
  end

  describe '#initialize' do
    it 'exists' do
      turn = Turn.new(@board)

      expect(turn).to be_a(Turn)
      expect(turn.board).to be_a(Board)
      expect(turn.winner).to be_nil
    end

    it 'can initialize another turn' do
      turn2 = Turn.new(@board)

      expect(turn2).to be_a(Turn)
      expect(turn2.board).to be_a(Board)
      expect(turn2.winner).to be_nil
    end
  end

  describe '#update_board' do
    it "adds  the player's piece to the column the player chooses" do
      player = Player.new
      turn = Turn.new(@board)
      input = 'A'
      turn.update_board(player, input)

      expect(@board.layout[:A]).to eq(['X', '*', '*', '*', '*', '*'])
    end

    it 'adds a second piece to the column the player chooses' do
      player = Player.new
      computer = Computer.new
      turn = Turn.new(@board)
      input = 'A'
      turn.update_board(player, input)
      input = 'A'
      turn.update_board(computer, input)

      expect(@board.layout[:A]).to eq(['X', 'O', '*', '*', '*', '*'])
    end

    it 'can add a piece to another column the player chooses' do
      user = Player.new
      computer = Computer.new
      turn = Turn.new(@board)
      input = 'A'
      turn.update_board(user, input)
      input = 'A'
      turn.update_board(computer, input)
      input = 'B'
      turn.update_board(user, input)

      expect(@board.layout[:A]).to eq(['X', 'O', '*', '*', '*', '*'])
      expect(@board.layout[:B]).to eq(['X', '*', '*', '*', '*', '*'])
    end
  end

  describe '#move' do
    it 'winner is nil if move does not win' do
      user = Player.new
      computer = Computer.new
      turn = Turn.new(@board)
      turn.move(user)
      turn.move(computer)

      expect(turn.winner).to eq(nil)
    end

    it 'player is the winner if players move wins' do
      user = Player.new
      turn = Turn.new(@board)
      @board.layout[:B] = ['X','*','*','*','*','*']
      @board.layout[:C] = ['X','*','*','*','*','*']
      @board.layout[:D] = ['X','*','*','*','*','*']
      turn.move(user) # when user input is A or E

      expect(turn.winner).to eq(user)
    end

    it 'computer is the winner if computers move wins' do
      computer = Computer.new
      turn = Turn.new(@board)
      @board.layout[:A] = ['O','O','O','*','*','*']
      @board.layout[:B] = ['O','O','O','*','*','*']
      @board.layout[:C] = ['O','O','O','*','*','*']
      @board.layout[:D] = ['*','*','*','*','*','*']
      @board.layout[:E] = ['O','O','O','*','*','*']
      @board.layout[:F] = ['O','O','O','*','*','*']
      @board.layout[:G] = ['O','O','O','*','*','*']
      turn.move(computer)

      expect(turn.winner).to eq(computer)
    end
  end

  describe '#valid?' do
    it 'returns false if the input is not from A to G' do
      turn = Turn.new(@board)
      input = 'z'

      expect(turn.valid?(input)).to eq(false)
    end

    it 'returns false if the input column is full' do
      turn = Turn.new(@board)
      @board.layout[:G] = ['O','O','O','O','O','O']
      input = 'G'

      expect(turn.valid?(input)).to eq(false)
    end

    it 'returns true if input is valid' do
      turn = Turn.new(@board)
      input = 'A'

      expect(turn.valid?(input)).to eq(true)
    end
  end
end
