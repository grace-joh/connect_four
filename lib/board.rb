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

  def create_rows
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
      print "#{create_rows[index].join(' ')}\n".lstrip
      index -= 1
    end
  end

  def column_free?(input)
    @layout[input.to_sym].include?('*')
  end

  def full?
    !@layout.values.flatten.include?('*')
  end

  def reset
    layout.keys.map { |letter| layout[letter] = ['*', '*', '*', '*', '*', '*'] }
  end
end
