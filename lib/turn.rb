class Turn
  attr_reader :board, :winner

  def initialize(board)
    @board = board
    @winner = nil
  end

  def update_board(player, input)
    next_open_space = @board.layout[input.to_sym].find_index('*')
    @board.layout[input.to_sym][next_open_space] = player.symbol
  end
end
