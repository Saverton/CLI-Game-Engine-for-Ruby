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
      food.spawn while snake.covers?(food.position)
      snake.grow
    end

    raise SnakeDeadError.new, 'GAME OVER' if snake_dies?
  end

  def snake_eats_food?
    snake.head == food.position
  end

  def snake_dies?
    snake.hits_self? || !snake_in_bounds?
  end

  def snake_in_bounds?
    (0...width).include?(snake.head[0]) && (0...height).include?(snake.head[1])
  end

  def render(canvas)
    canvas.rectangle(pos: [0, 0], dim: [width + 2, height + 2], fill: false, char: '#', color: :red)
  end
end
