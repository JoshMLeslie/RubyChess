require_relative '../chess_piece'
require_relative 'slidable'

class Bishop < ChessPiece
  include Slidable

  def initialize(color, pos)
    symbol_update = (color == :white ?  "7" : "D")
    super(color, pos, symbol_update)
    # => ChessPiece.new(color, pos, symbol)
  end

end # class end
