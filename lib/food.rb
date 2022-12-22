# frozen_string_literal: true

# Food class manages the food that the snake can eat
class Food
  attr_accessor :x_pos, :y_pos
  attr_reader :snake

  def initialize
    spawn
  end

  def spawn
    self.x_pos = rand(0..19)
    self.y_pos = rand(0..19)
  end

  def position
    [x_pos, y_pos]
  end

  def render(canvas, off_x, off_y)
    canvas.point(x_pos: x_pos + off_x, y_pos: y_pos + off_y, char: '@')
  end
end
