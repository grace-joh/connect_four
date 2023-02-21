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
end