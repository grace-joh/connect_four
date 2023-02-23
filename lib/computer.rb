require './lib/player'

class Computer < Player
  attr_reader :symbol

  def initialize(symbol)
    super(symbol)
  end

  def input
    ('A'..'G').to_a.sample
  end
end
