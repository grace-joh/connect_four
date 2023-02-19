require 'spec_helper'

RSpec.describe Computer do
  describe '#initialize' do
    it 'exists' do
      computer = Computer.new

      expect(computer).to be_a(Computer)
      expect(computer.symbol).to eq('O')
      expect(computer.input).to be_nil
    end

    it 'can initialize another object' do
      computer2 = Computer.new

      expect(computer2).to be_a(Computer)
      expect(computer2.symbol).to eq('O')
      expect(computer2.input).to be_nil
    end
  end
end
