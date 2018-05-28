require 'byebug'
require 'colorize'
require_relative '../pieces/all_pieces'

class Game

  PIECES_POS = [
    :Rook, :Knight, :Bishop, :King, :Queen, :Bishop, :Knight, :Rook
  ]


  attr_accessor :board

  def initialize
    @board = make_and_fill_board
  end

  def [](pos)
    x, y = pos
    board[x][y]
  end

  def []=(pos,piece)
    x,y = pos
    board[x][y] = piece
  end

  def make_and_fill_board
    temp_board = Array.new(8) { Array.new(8) }

    temp_board.map.with_index do |row, row_i|
      row.map.with_index do |col, col_i|
        case row_i
          when 0, 7
            col = place_piece(row_i, col_i)
          when 1, 6
            col = place_pawn(row_i, col_i)
          else
            col = NullPiece.instance
        end
      end
    end
  end # make and fill board END

  def place_piece(row_i, col_i)
    color = (row_i == 0 ? :white : :black)

    # PIECES == :Rook, etc.
    cur_class = PIECES_POS[col_i]
    # Converts to class_name_object_thing
    cur_class = Kernel.const_get(cur_class)
    # Makes a new piece of class, color, indexes
    new_piece = cur_class.new(color, [row_i, col_i])
    return new_piece
  end

  def place_pawn(row_i, col_i)
    color = (row_i == 1 ? :white : :black)
    # Makes a new piece of class, color, indexes
    new_piece = Pawn.new(color, [row_i, col_i])
    return new_piece
  end

  def move_piece
    begin
      start_pos, end_pos = get_moves
      check_start_pos(start_pos)
      check_end_pos(end_pos)
    rescue StandardError => e
      puts "#{e}: Invalid move, try again."
      retry
    end
    #

    # flip pieces ## @set = draw
    self[end_pos], self[start_pos] = self[start_pos], self[end_pos]
  end

  def valid_pos?(pos)
    pos.all? { |val| val.between?(0,7) }
  end

  def in_check?(color)
    # call as board.in_check?(color)
    # color is a symbol

    king_pos = self.piece_pos("King", color)

    # cycle through each of the other possible color pieces' positions
    other_color = (color == :white ? :black : :white)
    other_side = {} # other_color: other_color
    pieces = [:Pawn].concat(PIECES_POS[0..4])

    other_side.merge!(piece_pos(pieces,other_color))

    other_side.each do |piece_name, pieces|

      pieces.each do |piece|
        return {pieces: pieces, king_pos: king_pos} if piece.valid_move?(king_pos)
      end
    end

    return false
  end

  def checkmate?(color)
    data = in_check?(color)
    if data
      pieces = data[:pieces]
      king_pos = data[:king_pos]
      kings_moves = King.king_move_radius(king_pos)
      return kings_moves.any? {|move| check_end_pos(move)}
    else
      return data # false
    end
  end

  def piece_pos(find_piece,color)

    # self is the game
    # if given an array of pieces, returns an array
    # else returns a single piece obj

    result = Hash.new {|h,k| h[k] = []}
    if find_piece.class.to_s == "Array"
      self.board.each do |row|
        row.each do |piece|
          if find_piece.include?(piece.class.to_s.intern) &&
            piece.color == color

             result[piece.class.to_s] << piece
          end
        end
      end
      return result
    else
      self.board.each do |row|
        row.each do |piece|
          if piece.class.to_s == find_piece &&
            piece.color == color

            return piece.current_pos
          end
        end
      end
    end
  end

private
  def get_moves
    result = []
    2.times do |n|
      begin
        puts "Input value 'x,y': "
        temp_result = gets.chomp.scan(/\d+/).map(&:to_i)
        valid?(temp_result) # tests temp result
      rescue
        puts "Input is invalid, try again."
        retry
      end

      result << temp_result
    end
    result
  end

  def valid?(temp_result)
    raise StandardError if temp_result.invalid
  end

  def invalid
    self.length == 2 || self.any? { |val| val < 0 || val > 7 }
  end

  def check_start_pos(start_pos) #make error more detailed
    #returns true if end_pos is ChessPiece
    return true if self[start_pos].is_a?(ChessPiece)
    raise StandardError.new("Start_pos Error, not a piece")
  end

  def check_end_pos(end_pos)
    #returns true if end_pos is NullPiece
    return true if self[end_pos].is_a?(NullPiece)
    raise StandardError.new("End_pos Error, space occupied")
  end




end # class end


if __FILE__ == $PROGRAM_NAME
  b = Board.new
  b.move_piece
  b.display

end
