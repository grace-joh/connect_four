class Player 
  attr_reader :type, :symbol

  def initialize(type, symbol)
    @type = type
    @symbol = symbol
  end
end