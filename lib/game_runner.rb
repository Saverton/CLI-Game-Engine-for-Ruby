# frozen_string_literal: true

require 'io/console'

# Game Runner, takes a game object and runs it as a game
class GameRunner
  attr_accessor :game_object

  def initialize(game_object)
    @game_object = game_object
  end

  def run_game
    cursor = TTY::Cursor
    cursor.invisible do
      puts 'GAME LOADING...'
      game_object.load
      run_frame until game_object.quit?
      puts 'GAME TERMINATED'
    end
  end

  private

  def run_frame
    game_object.reader.read_keypress(nonblock: true, echo: false)
    game_object.update

    game_object.render
    game_object.draw

    sleep game_object.frame_interval
  end
end
