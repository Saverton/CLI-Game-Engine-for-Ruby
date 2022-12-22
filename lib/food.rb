# frozen_string_literal: true

# Food class manages the food that the snake can eat
class Food
  attr_accessor :position
  attr_reader :snake

  def initialize
    spawn
  end

  def spawn
    self.position = [rand(0..19), rand(0..19)]
  end

  def render(canvas, off_x, off_y)
    on_screen_food = [position[0] + off_x, position[1] + off_y]
    canvas.point(pos: on_screen_food, char: '@', color: :yellow)
  end
end
