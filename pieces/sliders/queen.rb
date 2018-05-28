require_relative '../chess_piece'
require_relative 'slidable'

class Queen < ChessPiece
  include Slidable

  def initialize(color, pos)
    symbol_update = (color == :white ?  "5" : "B")
    super(color, pos, symbol_update)
    # => ChessPiece.new(color, pos, symbol)
  end

end # class end
