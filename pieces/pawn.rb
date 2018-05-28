require 'byebug'
require_relative 'chess_piece'

class Pawn < ChessPiece

  ATTACKS_OFFSET = [
    [-1,-1], [-1, 1],
    [1,-1],  [1,1]
  ]

  def initialize(color, pos)
    symbol_update = (color == :white ?  "9" : "F")
    super(color, pos, symbol_update)
    # => ChessPiece.new(color, pos, symbol)
  end

  def move(to_pos)
    # current_pos +- 1 y
    x, y = to_pos
    if valid_move?(x, y)
      self.update_pos(to_pos) # update self to new_pos
      return to_pos
    else
      false
    end
  end

  def valid_move?(x, y)
    if y == current_pos[1]
      case color
        when :white
          move_one, move_two = -1,-2
        when :black
          move_one, move_two = 1,2
        else
          raise "Bad pawn color"
      end #case end

      case check_max_move
        when 1
          return current_pos[0] + move_one == x
        when 2
          return current_pos[0] + move_two == x
        else
          return false
      end #case end
    end

    return false
  end

  def check_max_move
    # if row == 1 or 6, max_move == 2 : max_move == 1
    case current_pos[0]
      when 1, 6
        return 2
      else
        return 1
    end #case end
  end

  def attack_move(attack_pos)
    if valid_move?(attack_pos)
      self.update_pos(attack_pos)  # update self to new_pos
      return attack_pos
    else
      false
    end
  end

  def valid_move?(attack_pos)
    ATTACKS_OFFSET.any? { |move| move == attack_pos }
  end

end # class end
