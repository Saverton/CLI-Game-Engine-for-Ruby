# frozen_string_literal: true

# GameObject is a generic parent class for all games
class GameObject
  attr_writer :quit
  attr_reader :reader, :frame_interval
  attr_accessor :canvas

  def initialize(width: 10, height: 10, frame_interval: 0.2)
    self.quit = false
    self.canvas = Canvas.new(width: width, height: height)
    @frame_interval = frame_interval
    @reader = TTY::Reader.new
    reader.on(:keyescape) do
      quit_game
    end
  end

  def load
    puts 'loading an empty game...'
  end

  def update
    puts 'updating an empty game...'
  end

  def render
    puts 'rendering an empty game...'
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
