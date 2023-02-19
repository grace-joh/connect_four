class Computer
  attr_reader :symbol

  def initialize
    @symbol = 'O'
  end

  def input
    ('A'..'G').to_a.sample
  end
end
