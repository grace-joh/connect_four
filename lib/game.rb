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
    system('clear')
    puts File.read('connect_four.txt')
    loop do
      puts 'Enter S to start or Q to quit.'
      input = $stdin.gets.chomp.upcase
      output_goodbye if input == 'Q'
      break if input == 'S'
    end
  end

  def output_goodbye
    system('clear')
    abort('Bye!')
  end

  def output_welcome
    system('clear')
    puts 'Welcome to Connect 4!'
    @turn.board.print_layout
  end

  def take_turns
    loop do
      players.each do |player|
        output_turn(player)
        turn.move(player)
        break unless @winner.nil?
      end
      break if @turn.board.full? || !@winner.nil?
    end
  end

  def output_turn(player)

  end

  def output_winner

  end

  def output_play_again

  end
end
