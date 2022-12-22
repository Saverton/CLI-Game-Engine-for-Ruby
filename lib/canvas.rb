# frozen_string_literal: true

# Canvas is simply a 2d array of chars, contains multiple instance methods for drawing shapes, text, and other objects.
class Canvas
  attr_reader :canvas, :c_width, :c_height

  X = 0
  Y = 1

  def initialize(width:, height:)
    @canvas = Array.new(height).map { Array.new(width) }
    @c_width = width
    @c_height = height
    clear
  end

  def clear
    canvas.each { |row| row.fill(' ') }
  end

  def print(str:, pos:)
    row = insert_into_row(row: canvas[pos[Y]], arr: str.split(''), pos: pos)
    canvas[pos[Y]] = row.slice(0...c_width)
  end

  def rectangle(pos:, width:, height:, fill: false, char: '#')
    (pos[Y]...(pos[Y] + height)).each do |y_index|
      if fill || y_index == pos[Y] || y_index == pos[Y] + height - 1
        solid_line(char: char, pos: [pos[X], y_index], length: width)
      else
        end_points(char: char, pos: [pos[X], y_index], length: width)
      end
    end
  end

  def point(pos:, char:)
    canvas[pos[Y]][pos[X]] = char
  end

  # draws the canvas to the console
  def draw
    system('clear') || system('cls')
    canvas.each do |row|
      puts row.join('')
    end
  end

  private

  def solid_line(char:, pos:, length:)
    row = canvas[pos[Y]]
    row.slice!(pos[X], length)
    length.times do
      row.insert(pos[X], char)
    end
    canvas[pos[Y]] = row.slice(0..(c_width - 1))
  end

  def end_points(char:, pos:, length:)
    canvas[pos[Y]][pos[X]] = char
    canvas[pos[Y]][pos[X] + length - 1] = char if pos[X] + length <= c_width
  end

  def insert_into_row(row:, arr:, pos:)
    row.slice(0...pos[X]) + arr + row.slice(pos[X] + arr.length..)
  end
end
