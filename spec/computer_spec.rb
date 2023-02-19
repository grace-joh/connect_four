require 'spec_helper'

RSpec.describe Computer do
  describe '#initialize' do
    it 'exists' do
      computer = Computer.new

      expect(computer).to be_a(Computer)
      expect(computer.symbol).to eq('O')
      expect(computer.input).to be_nil
    end
  end
end
