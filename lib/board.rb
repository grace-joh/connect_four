class Board
  attr_reader :layout

  def initialize
    @layout = {
      A: ['*','*','*','*','*','*'],
      B: ['*','*','*','*','*','*'],
      C: ['*','*','*','*','*','*'],
      D: ['*','*','*','*','*','*'],
      E: ['*','*','*','*','*','*'],
      F: ['*','*','*','*','*','*'],
      G: ['*','*','*','*','*','*']
    }
  end

  def rows
    rows = [[], [], [], [], [], []]
    @layout.each_value do |column_array|
      column_array.each_with_index do |space, index|
        rows[index] << space
      end
    end
    rows
  end

  def print_layout
    print "#{@layout.keys.join(' ')}\n"
    index = 5
    while index >= 0
      print "#{rows[index].join(' ')}\n".lstrip
      index -= 1
    end
  end

  def column_free?(input)
    @layout[input.to_sym].include?('*')
  end

  def full?
    !@layout.values.flatten.include?('*')
  end

  def win?
    if vertical_win?(symbol) || horizontal_win?(symbol) || diagonal_win?(symbol)
      true
    else 
      false
    end
  end

  def vertical_win?(symbol)
    win = false
    @layout.values.each do |column_array|
      win = true if column_array.each_cons(4).any? {|symbol| symbol.uniq.size == 1}
    end
    win
  end

  def horizontal_win?(symbol)
    win = false
    rows.each do |row|
      win = true if row.each_cons(4).any? { |element, next_element| element == symbol && next_element == symbol }
    end
    win
  end

  def diagonal_win?(symbol)
    win = false
    diagonal_arrays.each do |diagonal|
      win = true if diagonal.all?(symbol)
    end
    win
  end

  def diagonal_arrays = []
    for move_up in 0..2
      for move_right in 0..3
        up_diagonal = [] 
          down_diagonal = []
        for key_index in 0..3
          up_diagonal << layout[layout.keys[key_index + move_right]][key_index + move_up]
          down_diagonal << layout[layout.keys[key_index + move_right]][-key_index + 3 + move_up]
        end
        diagonal_arrays << up_diagonal
        diagonal_arrays << down_diagonal
      end
    end
  end
end
