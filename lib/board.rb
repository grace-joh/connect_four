class Board
  attr_reader :layout 

  def initialize
    @layout = {
      A: ["*","*","*","*","*","*"],
      B: ["*","*","*","*","*","*"],
      C: ["*","*","*","*","*","*"],
      D: ["*","*","*","*","*","*"],
      E: ["*","*","*","*","*","*"],
      F: ["*","*","*","*","*","*"],
      G: ["*","*","*","*","*","*"]
    }
  end

  def print
    puts @layout.keys.join(" ")
    index = 6
    while index >= 0
      print_array = []
      @layout.values.each do |column_array|    
        print_array << column_array[index]
      end
      puts print_array.join(" ")    
      index -= 1
    end
  end
end
