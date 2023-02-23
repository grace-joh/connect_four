class Game
  attr_reader :player1, :player2, :turn, :winner

  def initialize
    @player1 = Player.new('X')
    @player2 = Computer.new('O')
    @turn = Turn.new
    @winner = nil
  end

  def players
    [@player1, @player2]
  end

  def play
    system('clear')
    loop do
      output_start
      output_welcome
      take_turns
      output_winner
      output_play_again
    end
  end

  def output_start
    puts File.read('connect_four.txt')
    loop do
      puts 'Enter S to start or Q to quit.'
      input = $stdin.gets.chomp.upcase
      output_goodbye if input == 'Q'
      break if input == 'S'
    end
  end

  def output_goodbye
    puts 'See ya later!'
    sleep 5
    system('clear')
    abort
  end

  def output_welcome
    system('clear')
    puts "Welcome to Connect 4!\n\n"
    @turn.board.print_layout
  end

  def take_turns
    loop do
      players.each do |player|
        output_turn(player)
        turn.move(player)
        @winner = @turn.winner
        break unless @winner.nil?
      end
      break if @turn.board.full? || !@winner.nil?
    end
  end

  def output_turn(player)
    if player == @player1
      puts "\nIt's your turn."
      puts 'Choose a column from A to G'
    else
      puts "\nIt's the computer's turn."
      sleep 3
    end
  end

  def output_winner
    if @winner == @player1
      puts 'You win!!!'
    elsif @winner == @player2
      puts 'You lose :('
    else
      puts 'This game was a draw.'
    end
    sleep 5
    system('clear')
    @turn.board.reset
    @turn.winner = nil
  end

  def output_play_again
    puts 'Play again?'
  end
end
