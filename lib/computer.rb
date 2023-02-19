class Computer
  attr_reader :symbol

  def initialize
    @symbol = 'O'
  end

  def input
    ['A', 'B', 'C', 'D', 'E', 'F', 'G'].sample(random: SecureRandom)
  end
end
