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
end
