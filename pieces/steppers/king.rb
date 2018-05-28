require_relative '../chess_piece'
require_relative 'steppers'

class King < ChessPiece
  include Stepper

  def initialize(color, pos)
    symbol_update = (color == :white ?  "4" : "A")
    super(color, pos, symbol_update)
    # => ChessPiece.new(color, pos, symbol)
  end

end # class end
