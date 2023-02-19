require 'spec_helper'
# require 'securerandom'

RSpec.describe Computer do
  describe '#initialize' do
    it 'exists' do
      computer = Computer.new

      expect(computer).to be_a(Computer)
      expect(computer.symbol).to eq('O')
    end

    it 'can initialize another object' do
      computer2 = Computer.new

      expect(computer2).to be_a(Computer)
      expect(computer2.symbol).to eq('O')
    end
  end

  describe '#input' do
    it 'returns a letter from A to G randomly' do
      computer = Computer.new

      expect(computer.input).to be_a(String)
      # allow(SecureRandom).to receive(:input).and_return('Z')
      # expect(computer.input).to eq('A')  # how to test for other letters  || 'B' || 'C' || 'D' || 'E' || 'F' || 'G'
      # expect(computer.input).not_to eq('Z')
    end
  end
end
