require 'spec_helper'

RSpec.describe Game do
  before(:each) do
    @game = Game.new
  end

  describe '#initialize' do
    it 'exists' do
      expect(@game).to be_a(Game)
      expect(@game.player1).to be_a(Player)
      expect(@game.player2).to be_a(Computer)
      expect(@game.turn).to be_a(Turn)
      expect(@game.winner).to be_nil
    end
  end

  describe '#players' do
    it 'returns an array of both players' do
      expect(@game.players).to eq([@game.player1, @game.player2])
      expect(@game.players.first).to be_a(Player)
      expect(@game.players.last).to be_a(Computer)
    end
  end

  # describe '#play' do
  #   it 'runs the game' do
  #   end
  # end

  # describe '#output_start' do
  #   it 'outputs game title and instructions to start' do
  #     expect { @game.output_start }.to output(' ').to_stdout
  #   end
  # end

  describe '#output_goodbye' do
    it 'says bye' do
      expect { @game.output_goodbye }.to output('Bye!').to_stdout
    end
  end

  describe '#output_welcome' do
    it 'says welcome and prints an empty board' do
      expect { @game.output_welcome }.to output("Welcome to Connect 4!\nA B C D E F G\n* * * * * * *\n* * * * * * *\n* * * * * * *\n* * * * * * *\n* * * * * * *\n* * * * * * *\n").to_stdout
    end
  end

  # describe '#take_turns' do
  #   it 'loops the players to take turns until there is a game winner' do
  #   end
  # end

  describe '#output_turn' do
    it 'alerts the user that it is their' do
      expect { @game.output_turn(@game.players.first) }.to output("It's your turn.\nChoose a column from A to G\n").to_stdout
    end

    it 'alerts the user that it is the computers turn' do
      computer = Computer.new
      expect { @game.output_turn(@game.players.last) }.to output("It's the computer's turn.\n").to_stdout
    end
  end

  describe '#output_winner' do
    it 'alerts the user if they win' do
      @game.winner = @game.players.first

      expect { @game.output_winner }.to output("You win!!!\n").to_stdout
    end

    it 'alerts the user if they lose' do
      @game.winner = @game.players.last

      expect { @game.output_winner }.to output("You lose :(\n").to_stdout
    end

    it 'alerts the user if the game ends with no winner' do
      @game.winner = nil

      expect { @game.output_winner }.to output("This game was a draw.\n").to_stdout
    end
  end

  describe '#output_play_again' do
    it 'ask the user if they want to play again' do
      expect { @game.output_play_again }.to output("Play again?\n").to_stdout
    end
  end
end
