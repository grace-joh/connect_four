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
end
