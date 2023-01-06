# frozen_string_literal: true

# Canvas is simply a 2d array of chars, contains multiple instance methods for drawing shapes, text, and other objects.
class Canvas
  attr_reader :canvas, :color_map, :c_width, :c_height
  attr_accessor :last_canvas

  X = 0
  Y = 1
  WIDTH = 0
  HEIGHT = 1

  def initialize(width:, height:)
    @canvas = Array.new(height).map { Array.new(width) }
    @last_canvas = []
    @color_map = Array.new(height).map { Array.new(width) }
    @c_width = width
    @c_height = height
    clear
    system('clear') || system('cls')
  end

  def clear
    self.last_canvas = deep_copy(canvas)
    canvas.each { |row| row.fill(' ') }
    color_map.each { |row| row.fill(nil) }
  end

  def print_str(str:, pos:, color: nil)
    row = insert_into_row(row: canvas[pos[Y]], arr: str.split(''), pos: pos)
    canvas[pos[Y]] = row.slice(0...c_width)
    color_row(row_index: pos[Y], start: pos[X], length: str.length, color: color)
  end

  def rectangle(pos:, dim:, fill: false, char: '#', color: nil)
    (0...dim[HEIGHT]).each do |y_index|
      row_idx = pos[Y] + y_index
      if fill || [0, dim[HEIGHT] - 1].include?(y_index)
        print_str(str: char * dim[WIDTH], pos: [pos[X], row_idx], color: color)
      else
        end_points(char: char, pos: [pos[X], row_idx], length: dim[WIDTH], color: color)
      end
    end
  end

  def point(pos:, char:, color: nil)
    canvas[pos[Y]][pos[X]] = char
    color_point(pos: pos, color: color)
  end

  # draws the canvas to the console
  def draw
    cursor = TTY::Cursor
    canvas.each.with_index do |row, i|
      row.each.with_index do |char, j|
        if last_canvas[i][j] != char
          color = color_map[i][j] || :white
          print cursor.move_to(j, i), Paint[char, color, :bright]
        end
      end
      puts
    end
  end

  private

  def solid_line(char:, pos:, length:, color:)
    print_str(str: char * length, pos: pos, color: color)
  end

  def end_points(char:, pos:, length:, color:)
    point(pos: pos, char: char, color: color)
    point(pos: [pos[X] + length - 1, pos[Y]], char: char, color: color)
  end

  def insert_into_row(row:, arr:, pos:)
    row.slice(0...pos[X]) + arr + row.slice(pos[X] + arr.length..)
  end

  def color_row(row_index:, start:, length:, color:)
    to = [start + length, c_width].min
    (start...to).each do |i|
      color_map[row_index][i] = color
    end
  end

  def color_point(pos:, color:)
    color_map[pos[Y]][pos[X]] = color
  end

  def deep_copy(arr)
    new_arr = []
    arr.each do |element|
      new_arr << (element.is_a?(Array) ? deep_copy(element) : element)
    end
    new_arr
  end
end
