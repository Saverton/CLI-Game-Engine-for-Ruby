# frozen_string_literal: true

# Game Runner, takes a game object and runs it as a game
class GameRunner
  attr_accessor :game_object

  def initialize(game_object)
    @game_object = game_object
  end

  def run_game
    game_object.load
    until game_object.quit?
      game_object.update
      game_object.render
      system('clear') || system('cls')
      game_object.draw
      sleep 0.2
    end
    puts 'GAME ENDED'
  end
end
