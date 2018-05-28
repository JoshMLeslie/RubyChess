require 'byebug'
require "io/console"

KEYMAP = {
  " " => :space,
  "h" => :left,
  "j" => :down,
  "k" => :up,
  "l" => :right,
  "w" => :up,
  "a" => :left,
  "s" => :down,
  "d" => :right,
  "\t" => :tab,
  "\r" => :return,
  "\n" => :newline,
  "\e" => :escape,
  "\e[A" => :up,
  "\e[B" => :down,
  "\e[C" => :right,
  "\e[D" => :left,
  "\177" => :backspace,
  "\004" => :delete,
  "\u0003" => :ctrl_c,
}

MOVES = {
  left: [0, -1],
  right: [0, 1],
  up: [-1, 0],
  down: [1, 0]
}

class Cursor

  attr_reader :cursor_pos, :game

  def initialize(cursor_pos, game)
    # cursor_pos is [x,y]
    @cursor_pos = cursor_pos
    @game = game
  end

  def get_input
    key = KEYMAP[read_char]
    handle_key(key)
  end

private
  def read_char
    STDIN.echo = false # stops the console from printing return values

    STDIN.raw!
    # in raw mode data is given as is to the program--the system doesn't preprocess special characters such as control-c

    input = STDIN.getc.chr
    # STDIN.getc reads a one-character string as a numeric keycode. chr returns a string of the character represented by the keycode. (e.g. 65.chr => "A")

    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil
      # read_nonblock(maxlen) reads at most maxlen bytes from a data stream; it's nonblocking, meaning the method executes asynchronously; it raises an error if no data is available, hence the need for rescue

      input << STDIN.read_nonblock(2) rescue nil
    end

    STDIN.echo = true # the console prints return values again
    STDIN.cooked! # the opposite of raw mode :)

    return input
  end

  def handle_key(key)
    case key
      when :return, :space
        cursor_pos
      when :left, :right, :up, :down
        diff = MOVES[key]
        update_pos(diff)
        return nil
      when :ctrl_c
        puts "Exiting program."
        Process.exit(0)
    end # case end
  end

  def update_pos(diff)
    # dif is [+-1, +- 1]
    x, y = diff
    check_pos = [@cursor_pos[0] + x , @cursor_pos[1] + y]

    if game.valid_pos?(check_pos)
      @cursor_pos[0] += x
      @cursor_pos[1] += y
    end
  end
end