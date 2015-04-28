require_relative 'piece.rb'
require 'colorize'

class Board
  LETTER_MAPPING = {
    A: 0,
    B: 1,
    C: 2,
    D: 3,
    E: 4,
    F: 5,
    G: 6,
    H: 7
  }

  NUMBER_MAPPING = {
    1 => 7,
    2 => 6,
    3 => 5,
    4 => 4,
    5 => 3,
    6 => 2,
    7 => 1,
    8 => 0
  }


  def initialize
    @grid = Array.new(8) { Array.new(8) {nil} }
    set_board
  end

  def [](x, y)
    @grid[x][y]
  end

  def dark_square_eval( x, y )
    if self[x,y].nil?
      "    ".colorize(background: :blue)
    else
      piece = self[x,y]
      "  #{piece.display.colorize(color: piece.color)} "
        .colorize(background: :blue)
    end
  end

  def light_square_eval( x, y )
    if self[x,y].nil?
      "    ".colorize(background: :red)
    else
      piece = self[x,y]
      "  #{piece.display.colorize(color: piece.color)} "
        .colorize(background: :red)
    end
  end


  def parse(input)
    #input is like 'e5'
    input_array = input.split('')
    x, y = input_array[0].upcase.to_sym , input_array[1].to_i
    pos_x, pos_y = LETTER_MAPPING[x], NUMBER_MAPPING[y]
    [pos_x, pos_y]
  end

  def render
    board_display_array = Array.new(8) {''}

    8.times do |row|
      grid[row].each do |col|
        if (row + col) % 2 == 0
          board_display_array[row] += light_square_eval( [row, col] )
        else
          board_display_array[row] += dark_square_eval( [row, col] )
        end
      end
    end

    board_display_array.each{|row| puts row}
  end

  





end
