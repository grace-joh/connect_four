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
end
