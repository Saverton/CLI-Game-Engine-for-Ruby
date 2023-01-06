# frozen_string_literal: true

# Class for running a game of Snake
class SnakeGame < GameObject
  attr_reader :snake, :food, :grid

  def initialize
    super(width: 22, height: 22, frame_interval: 0.15)
  end

  def load
    @snake = Snake.new(reader: reader)
    @food = Food.new
    @grid = Grid.new(snake: snake, food: food)
    3.downto(1) do |i|
      puts "Game starts in #{i}..."
      sleep 1
    end
  end

  def update
    snake.update
    grid.update
  rescue SnakeDeadError => _e
    quit_game
  end

  def render
    snake.render(canvas, 1, 1)
    food.render(canvas, 1, 1)
    grid.render(canvas)
    canvas.print_str(str: " SCORE #{snake.size} ", pos: [1, 0])
    render_game_over if quit?
  end

  private

  def render_game_over
    canvas.rectangle(pos: [3, 7], dim: [16, 6], fill: true, char: ' ')
    canvas.rectangle(pos: [3, 7], dim: [16, 6], fill: false, char: '*', color: :blue)
    canvas.print_str(str: 'GAME  OVER', pos: [6, 9], color: :yellow)
    canvas.print_str(str: "SCORE #{snake.size}", pos: [7, 10], color: :yellow)
  end
end
