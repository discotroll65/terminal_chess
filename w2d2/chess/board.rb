require_relative 'piece.rb'
require 'colorize'
require 'byebug'

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



  def dark_square_eval( (x, y) )
    if self[x,y].nil?
      "   ".colorize(background: :blue)
    else
      piece = self[x,y]
      " #{piece.display.colorize(color: piece.color)} "
        .colorize(background: :blue)
    end
  end

  def light_square_eval((x, y))
    if self[x,y].nil?
      "   ".colorize(background: :red)
    else
      piece = self[x,y]

      " #{piece.display.colorize(color: piece.color)} "
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

  def show_board
    board_display_array = Array.new(8) {''}

    8.times do |row|
      @grid[row].each_index do |col|
        if (row + col) % 2 == 0
          board_display_array[row] += light_square_eval( [row, col] )
        else
          board_display_array[row] += dark_square_eval( [row, col] )
        end
      end
    end

    board_display_array.each{|row| puts row}
  end


private

  def set_board
    white_royals = [
      Rook.new(board: self, pos: [7, 0], color: :white),
      Knight.new(board: self, pos: [7, 1], color: :white),
      Bishop.new(board: self, pos: [7, 2], color: :white),
      Queen.new(board: self, pos: [7, 3], color: :white),
      King.new(board: self, pos: [7, 4], color: :white),
      Bishop.new(board: self, pos: [7, 5], color: :white),
      Knight.new(board: self, pos: [7, 6], color: :white),
      Rook.new(board: self, pos: [7, 7], color: :white)
      ]

    black_royals = [
      Rook.new(board: self, pos: [0, 0], color: :black),
      Knight.new(board: self, pos: [0, 1], color: :black),
      Bishop.new(board: self, pos: [0, 2], color: :black),
      Queen.new(board: self, pos: [0, 3], color: :black),
      King.new(board: self, pos: [0, 4], color: :black),
      Bishop.new(board: self, pos: [0, 5], color: :black),
      Knight.new(board: self, pos: [0, 6], color: :black),
      Rook.new(board: self, pos: [0, 7], color: :black)
      ]

    white_pawns = [
      Pawn.new(board: self, pos: [6, 0], color: :white),
      Pawn.new(board: self, pos: [6, 1], color: :white),
      Pawn.new(board: self, pos: [6, 2], color: :white),
      Pawn.new(board: self, pos: [6, 3], color: :white),
      Pawn.new(board: self, pos: [6, 4], color: :white),
      Pawn.new(board: self, pos: [6, 5], color: :white),
      Pawn.new(board: self, pos: [6, 6], color: :white),
      Pawn.new(board: self, pos: [6, 7], color: :white)
      ]

    black_pawns = [
      Pawn.new(board: self, pos: [1, 0], color: :black),
      Pawn.new(board: self, pos: [1, 1], color: :black),
      Pawn.new(board: self, pos: [1, 2], color: :black),
      Pawn.new(board: self, pos: [1, 3], color: :black),
      Pawn.new(board: self, pos: [1, 4], color: :black),
      Pawn.new(board: self, pos: [1, 5], color: :black),
      Pawn.new(board: self, pos: [1, 6], color: :black),
      Pawn.new(board: self, pos: [1, 7], color: :black)
      ]

    8.times do |col|
      @grid[0][col] = black_royals[col]
      @grid[1][col] = black_pawns[col]
      @grid[6][col] = white_pawns[col]
      @grid[7][col] = white_royals[col]
    end
  end
end


board = Board.new
board.show_board
