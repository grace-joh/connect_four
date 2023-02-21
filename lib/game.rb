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

  def play
    loop do
      output_start
      output_welcome
      take_turns
      output_winner
      output_play_again
    end
  end

  def output_start

  end

  def output_goodbye

  end

  def output_welcome

  end

  def take_turns

  end

  def output_turn(player)

  end

  def output_winner

  end

  def output_play_again
    
  end
end
