require 'byebug'

module Stepper
  KNIGHTS_OFFSET = [
    [-1,-2], [1,-2],
    [-2,-1], [2,-1],
    [-2,-1], [2,1],
    [-1, 2], [1,2]
  ]

  KINGS_OFFSET = [
    # moves from center, [+0-,+0-] in all directions
    [-1,-1], [-1,0], [-1, 1],
    [0, -1],         [0, 1],
    [1, -1], [1, 0], [1, 1],
  ]


  def find_attempted_move(to_pos)
    x, y = to_pos
    [x - current_pos[0], y - current_pos[1]]
  end

  def valid_move?(to_pos)
    check_pos = find_attempted_move(to_pos)
    offsets = self.king_or_knave
    offsets.any? { |move| move == check_pos }
  end

  def self.king_move_radius(king_pos)
    return StandardError unless self.class == King
    # self is King
    return KINGS_OFFSET.map do |offset|
      [
        self[0] + offset[0],
        self[1] + offset[1]
      ]
    end
  end

  def king_or_knave
    if self.is_a?(King)
      return KINGS_OFFSET
    elsif self.is_a?(Knight)
      return KNIGHTS_OFFSET
    else
      raise "Steppable class error."
    end
  end
end
