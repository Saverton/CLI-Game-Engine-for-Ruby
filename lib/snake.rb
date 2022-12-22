# frozen_string_literal: true

# Snake class defines the snake in Snake.
class Snake
  include Movable

  attr_accessor :segments, :dir, :size
  attr_reader :reader

  DIRECTION_CHARS = {
    right: '<',
    left: '>',
    down: '^',
    up: 'v'
  }.freeze

  def initialize(reader:, x_pos: 0, y_pos: 5, dir: :right)
    self.segments = [[x_pos, y_pos]]
    self.size = 1
    self.dir = dir

    @reader = reader
    reader.on(:keyup, :keydown, :keyleft, :keyright) do |event|
      change_direction(dir: event.key.name, can_turn_back: false)
    end
  end

  def update
    segments.unshift(move(head))
    segments.slice!(size..)
  end

  def render(canvas, off_x, off_y)
    segments.each do |segment|
      on_screen_segment = [segment[0] + off_x, segment[1] + off_y]
      canvas.point(pos: on_screen_segment, char: 'O', color: :green)
    end
    on_screen_head = [head[0] + off_x, head[1] + off_y]
    canvas.point(pos: on_screen_head, char: head_char, color: :green)
  end

  def head
    segments.first
  end

  def head_char
    DIRECTION_CHARS[dir]
  end

  def grow
    self.size += 1
  end

  def hits_self?
    segments.slice(1..).filter { |segment| segment == head }.length.positive?
  end

  def covers?(point)
    segments.filter { |segment| segment == point }.length.positive?
  end
end
