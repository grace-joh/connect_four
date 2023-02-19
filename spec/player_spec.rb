require 'spec_helper'

RSpec.describe Player do
  describe '#initialize' do
    it 'exists' do
      player = Player.new

      expect(player).to be_a(Player)
      expect(player.symbol).to be_a(String)
      expect(player.input).to eq(nil)
    end
  end
end