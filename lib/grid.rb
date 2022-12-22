# frozen_string_literal: true

# Grid class manages the grid on which the game is played
class Grid
  attr_reader :width, :height, :snake, :food

  def initialize(snake:, food:, width: 20, height: 20)
    @snake = snake
    @food = food
    @width = width
    @height = height
  end

  def update
    if snake_eats_food?
      food.spawn while snake.inside?(food.position)
      snake.grow
    end

    raise SnakeDeadError.new, 'snake died, game over' if snake_dies?
  end

  def snake_eats_food?
    snake.head == food.position
  end

  def snake_dies?
    snake.hits_self? || !snake_in_bounds?
  end

  def snake_in_bounds?
    snake.head[0] >= 0 && snake.head[0] < width && snake.head[1] >= 0 && snake.head[1] < height
  end

  def render(canvas)
    canvas.rectangle(x_pos: 0, y_pos: 0, width: width + 2, height: height + 2, fill: false, char: '#')
  end
end
