require_relative '../chess_piece'
require_relative 'slidable'

class Rook < ChessPiece
  include Slidable

  def initialize(color, pos)
    symbol_update = (color == :white ?  "6" : "C")
    super(color, pos, symbol_update)
    # => ChessPiece.new(color, pos, symbol)
  end

end # class end
