class Turn
  attr_reader :board, :winner

  def initialize(board)
    @board = board
    @winner = nil
  end
end
