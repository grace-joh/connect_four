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

  def move(player)
    if player.class != Computer
      input = nil
      loop do
        input = $stdin.gets.chomp.upcase
        break if valid?(input)
      end
    else
      input = player.input until @board.column_free?(input)
    end
    update_board(player, input)
    system('clear')
    @board.print_layout
    @winner = player if @board.win?(player.symbol)
  end

  def valid?(input)
    valid = false
    if !('A'..'G').to_a.include?(input)
      puts 'invalid input! try again: A-G'
    elsif !@board.column_free?(input)
      puts "Column #{input} is full! try again"
    else
      valid = true
    end
    valid
  end
end
