# frozen_string_literal: true

# GameObject is a generic parent class for all games
class GameObject
  attr_writer :quit
  attr_reader :reader
  attr_accessor :canvas

  def initialize(width: 10, height: 10)
    self.quit = false
    self.canvas = Canvas.new(width: width, height: height)
    @reader = TTY::Reader.new
    reader.on(:keyescape) do
      quit_game
    end
  end

  def load
    puts 'loading an empty game...'
  end

  def update
    reader.read_keypress(nonblock: true, echo: false)
  end

  def render
    puts 'Your Game has no rendering method, please specify.'
  end

  def draw
    canvas.draw
    canvas.clear
  end

  def quit?
    @quit
  end

  def quit_game
    puts 'Quitting...'
    self.quit = true
  end
end
