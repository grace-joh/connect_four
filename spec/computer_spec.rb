require 'spec_helper'

RSpec.describe Computer do
  describe '#initialize' do
    it 'exists' do
      computer = Computer.new('O')

      expect(computer).to be_a(Computer)
      expect(computer.symbol).to eq('O')
    end

    it 'can initialize another object' do
      computer2 = Computer.new('O')

      expect(computer2).to be_a(Computer)
      expect(computer2.symbol).to eq('O')
    end

    it 'inherits behavior from Player' do
      computer = Computer.new('O')

      expect(Computer.superclass).to eq(Player)
    end
  end

  describe '#input' do
    it 'returns a letter from A to G randomly' do
      computer = Computer.new('O')

      expect(computer.input).to be_a(String)
      expect(('A'..'G').to_a).to include(computer.input)
      expect(('H'..'Z').to_a).not_to include(computer.input)
    end
  end