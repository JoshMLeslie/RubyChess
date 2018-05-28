require 'byebug'
require 'colorize'
require_relative 'cursor'
require_relative 'game'
require_relative '../pieces/chess_piece'

class Display

  attr_reader :cursor, :game, :board

  def initialize(game)

    @game = game
    @board = game.board
    @cursor = Cursor.new([0,0], game)
  end

  def render
    # render_board
    system "clear"
    print_arr = build_render
    render_cursor!(print_arr)
    make_pretty_array(print_arr)
  end

  def build_render
    print_arr = []

    0.upto(7) do |x|
      temp_arr = []

      0.upto(7) do |y|
        val = board_colorize(x,y)
        temp_arr << ["#{val}"]
      end

      print_arr << temp_arr # building rows
    end

    print_arr
  end

  def make_pretty_array(print_arr)
    print_arr.each do |row|
      pretty_row = ""

      8.times do |i|
        pretty_row += "#{row[i][0]}"
      end
      # colorize is severly lacking in some respects, results in this.
      puts pretty_row
    end

    # puts "\nHELLO WORLD. GLORY TO HYPNOTOAD."

    # game dev output #
    puts "\nHELLO WORLD. GLORY TO HYPNOTOAD.\nCursor: #{self.cursor.cursor_pos}\nKing in Check? #{game.in_check?(:black)}"
    # # #
  end

  def render_cursor!(print_arr)

    x, y = cursor.cursor_pos
    print_arr_val = print_arr[x][y][0]

    print_arr[x][y][0] = print_arr_val.colorize(:black).on_cyan
  end

  def board_colorize(x,y)
    # adds checkerboard pattern
    piece = board[x][y]

    if (x.odd? && y.odd?) || (x.even? && y.even?)
      piece.display.colorize(piece.color).on_light_blue
    else
      piece.display.colorize(piece.color).on_light_red
    end
  end

end # class end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  disp = Display.new(game)
  # disp.render
  # puts ""
  # move = [rand(8),rand(8)]
  disp.render
  input = disp.cursor.get_input
  until input == :crtl_c
    puts " "
    # if disp.cursor.get_input == :return
    #   debugger
    # end
    disp.render
    input = disp.cursor.get_input
  end

end
