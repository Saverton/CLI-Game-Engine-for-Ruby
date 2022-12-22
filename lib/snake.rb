# frozen_string_literal: true

# Snake class defines the snake in Snake.
class Snake
  attr_accessor :segments, :dir, :size
  attr_reader :reader

  DIRECTIONS = {
    right: [1, 0],
    left: [-1, 0],
    up: [0, -1],
    down: [0, 1]
  }.freeze

  DIRECTION_CHARS = {
    right: '<',
    left: '>',
    down: '^',
    up: 'v'
  }.freeze

  def initialize(reader:, x_pos: 0, y_pos: 5, dir: :right)
    self.segments = [[x_pos, y_pos]]
    self.size = 1
    self.change_direction = dir

    @reader = reader
    reader.on(:keyup, :keydown, :keyleft, :keyright) do |event|
      change_direction event.key.name
    end
  end

  def update
    delta = DIRECTIONS[dir]
    segments.unshift([head[0] + delta[0], head[1] + delta[1]])
    segments.slice!(size..)
  end

  def render(canvas, off_x, off_y)
    segments.each do |segment|
      canvas.point(x_pos: segment[0] + off_x, y_pos: segment[1] + off_y, char: 'O')
    end
    head_char = DIRECTION_CHARS[dir]
    canvas.point(x_pos: head[0] + off_x, y_pos: head[1] + off_y, char: head_char)
  end

  def head
    segments.first
  end

  def grow
    self.size += 1
  end

  def change_direction(dir)
    self.dir = dir
  end

  def hits_self?
    segments.slice(1..).filter { |segment| segment == head }.length.positive?
  end

  def inside?(point)
    segments.filter { |segment| segment == point }.length.positive?
  end
end
