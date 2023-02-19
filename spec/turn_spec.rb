require 'spec_helper'

RSpec.describe Turn do
  before(:each) do
    @board = Board.new
  end

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
