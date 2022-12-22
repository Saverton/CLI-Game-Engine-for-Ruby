# frozen_string_literal: true

# The Movable Module contains methods that apply to various moving things.
module Movable
  DIRECTIONS = {
    right: [1, 0],
    left: [-1, 0],
    up: [0, -1],
    down: [0, 1]
  }.freeze
  X = 0
  Y = 1

  def move(point)
    [point[X] + DIRECTIONS[dir][X], point[Y] + DIRECTIONS[dir][Y]]
  end

  def change_direction(dir:, can_turn_back: true)
    return unless can_turn_back || valid_side_move?(dir)

    self.dir = dir
  end

  private

  def valid_side_move?(dir)
    if horizontal?(self.dir)
      vertical?(dir)
    else
      horizontal?(dir)
    end
  end

  def horizontal?(dir)
    %i[right left].include?(dir)
  end

  def vertical?(dir)
    %i[up down].include? dir
  end
end
