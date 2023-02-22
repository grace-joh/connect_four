class Turn
  attr_reader :board, :winner

  def initialize
    @board = Board.new
    @winner = nil
  end

  def update_board(player, input)
    next_open_space = @board.layout[input.to_sym].find_index('*')
    @board.layout[input.to_sym][next_open_space] = player.symbol
  end

  def move(player)
    input = nil   
    if player.class != Computer
      loop do
        input = $stdin.gets.chomp.upcase
        break if valid?(input)
        input
      end
    else
      loop do
        input = player.input 
        break input if @board.column_free?(input)
      end
    end
    update_board(player, input)
    system('clear')
    @board.print_layout
    @winner = player if @board.win?(player.symbol)
  end

  def valid?(input)
    valid = false
    if !('A'..'G').to_a.include?(input)
      puts 'Invalid input! Try again: A-G'
    elsif !@board.column_free?(input)
      puts "Column #{input} is full! Try again"
    else
      valid = true
    end
    valid
  end
end
