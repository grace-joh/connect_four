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

  def print_layout
    print "#{@layout.keys.join(' ')}\n"
    index = 6
    while index >= 0
      print_array = []
      @layout.values.each do |column_array|
        print_array << column_array[index]
      end
      print "#{print_array.join(' ')}\n".lstrip
      index -= 1
    end
  end

  def column_free?(input)
      @layout[input.to_sym].include?('*')
  end
end
