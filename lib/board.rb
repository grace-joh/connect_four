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

  def diagonal_up_win?(symbol)
    win = false
    diagonal_up_arrays.each do |diagonal|
      win = true if diagonal.all?(symbol)
    end
    win
  end

  def diagonal_up_arrays
    diagonal_up_arrays = []
    for move_up in 0..2
      for move_right in 0..3
        single_diagonal = []
        for start_index in 0..3
          single_diagonal << @layout[@layout.keys[start_index + move_right]][start_index + move_up]
        end
        diagonal_up_arrays << single_diagonal
      end
    end
    diagonal_up_arrays
  end

  def diagonal_down_win?(symbol)
    win = false
    diagonal_down_arrays.each do |diagonal|
      win = true if diagonal.all?(symbol)
    end
    win
  end

  def diagonal_down_arrays
    diagonal_down_arrays = []
    for move_down in (5).downto(3)
      for move_right in 0..3
        single_diagonal = []
        for start_index in 0..3
          single_diagonal << @layout[@layout.keys[start_index + move_right]][start_index + move_down]
        end
        diagonal_down_arrays << single_diagonal
      end
    end
    diagonal_down_arrays
  end
end
