require 'spec_helper'

RSpec.describe Player do
  describe '#initialize' do
    it 'exists' do
      player = Player.new

      expect(player).to be_a(Player)
      expect(player.symbol).to be_a('X')
    end

    it 'can initialize another object' do
      player2 = Player.new 

      expect(player2).to be_a(Player)
      expect(player2.symbol).to be_a('X')
    end
  end
end