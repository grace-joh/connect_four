require 'spec_helper'

RSpec.describe Player do
  describe '#initialize' do
    it 'exists' do
      player = Player.new('X')

      expect(player).to be_a(Player)
      expect(player.symbol).to eq('X')
    end

    it 'can initialize another object' do
      player2 = Player.new('O')

      expect(player2).to be_a(Player)
      expect(player2.symbol).to eq('O')
    end
  end
end
