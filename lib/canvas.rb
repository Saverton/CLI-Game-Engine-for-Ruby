# frozen_string_literal: true

# Canvas is simply a 2d array of chars, contains multiple instance methods for drawing shapes, text, and other objects.
class Canvas
  attr_reader :canvas, :c_width, :c_height

  def initialize(width:, height:)
    @canvas = Array.new(height).map { Array.new(width) }
    @c_width = width
    @c_height = height
    clear
  end

  def clear
    canvas.each { |row| row.fill(' ') }
  end

  def print(str:, x_pos:, y_pos:)
    row = canvas[y_pos]
    row.slice!(x_pos, str.length)
    str.split('').reverse.each do |char|
      row.insert(x_pos, char)
    end
    canvas[y_pos] = row.slice(0..(c_width - 1))
  end

  def rectangle(x_pos:, y_pos:, width:, height:, fill: false, char: '#')
    (y_pos..(y_pos + height - 1)).each do |y_index|
      if fill || y_index == y_pos || y_index == y_pos + height - 1
        solid_line(char: char, x_pos: x_pos, y_pos: y_index, length: width)
      else
        end_points(char: char, x_pos: x_pos, y_pos: y_index, length: width)
      end
    end
  end

  def point(x_pos:, y_pos:, char:)
    canvas[y_pos][x_pos] = char
  end

  def draw
    canvas.each do |row|
      puts row.join('')
    end
  end

  private

  def solid_line(char:, x_pos:, y_pos:, length:)
    row = canvas[y_pos]
    row.slice!(x_pos, length)
    length.times do
      row.insert(x_pos, char)
    end
    canvas[y_pos] = row.slice(0..(c_width - 1))
  end

  def end_points(char:, x_pos:, y_pos:, length:)
    canvas[y_pos][x_pos] = char
    canvas[y_pos][x_pos + length - 1] = char if x_pos + length <= c_width
  end
end
