# not so cut and dry to refactor like this, but this is a bulk of it.

# require_relative '../pieces/steppers/step_require_helper'
# require_relative '../pieces/sliders/slide_require_helper'
# require_relative "../pieces/pawn"
#
# class Board
#
#   PIECES_POS = [
#     :Rook, :Knight, :Bishop, :King, :Queen, :Bishop, :Knight, :Rook
#   ]
#
#   attr_accessor :board
#
#   def initialize
#     @board = make_and_fill_board
#   end
#
#   def [](pos)
#     x, y = pos
#     board[x][y]
#   end
#
#   def []=(pos,piece)
#     x,y = pos
#     board[x][y] = piece
#   end
#
#   def make_and_fill_board
#     temp_board = Array.new(8) { Array.new(8) }
#
#     temp_board.map.with_index do |row, row_i|
#       row.map.with_index do |col, col_i|
#         case row_i
#           when 0, 7
#             col = place_piece(row_i, col_i)
#           when 1, 6
#             col = place_pawn(row_i, col_i)
#           else
#             col = NullPiece.instance
#         end
#       end
#     end
#   end # make and fill board END
#
#   def place_piece(row_i, col_i)
#     color = (row_i == 0 ? :white : :black)
#
#     # PIECES == :Rook, etc.
#     cur_class = PIECES_POS[col_i]
#     # Converts to class_name_object_thing
#     cur_class = Kernel.const_get(cur_class)
#     # Makes a new piece of class, color, indexes
#     new_piece = cur_class.new(color, [row_i, col_i])
#     return new_piece
#   end
#
#   def place_pawn(row_i, col_i)
#     color = (row_i == 1 ? :white : :black)
#     # Makes a new piece of class, color, indexes
#     new_piece = Pawn.new(color, [row_i, col_i])
#     return new_piece
#   end
#
# end
