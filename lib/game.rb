class Game
  attr_reader :player1, :player2, :turn, :winner

  def initialize
    @player1 = Player.new
    @player2 = Computer.new
    @turn = Turn.new
    @winner = @turn.winner
  end

  def players
    [@player1, @player2]
  end
end
