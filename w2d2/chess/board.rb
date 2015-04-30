require_relative 'pieces/pieces.rb'
require 'colorize'
require 'byebug'
require 'pry'

class Board
  attr_reader :grid

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


  def initialize(setup = true)
    @grid = Array.new(8) { Array.new(8) {nil} }
    set_board if setup
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, piece)
    x, y = pos
    @grid[x][y] = piece
  end

  def dark_square_eval(pos)
    x, y = pos
    if self[pos].nil?
      "   ".colorize(background: :blue)
    else
      piece = self[pos]
      " #{piece.display.colorize(color: piece.color)} "
        .colorize(background: :blue)
    end
  end


  def dup
    dup_board = Board.new(false)
    all_pieces = pieces(:black) + pieces(:white)

    all_pieces.each do |piece|
      duped_piece = piece.dup(dup_board)
      pos = duped_piece.pos
      dup_board[pos] = duped_piece
    end

    dup_board
  end

  def in_check?(color)
    other_color = (color == :white) ? :black : :white
    king = pieces(color).find{|piece| piece.is_a?(King)}

    pieces(other_color).any?{|piece| piece.moves.include?(king.pos) }
  end

  def in_check_mate?(color)
    pieces(color).all?{|piece| piece.valid_moves.empty? }
  end

  def inspect
    self.show_board
    nil
  end

  def light_square_eval(pos)
    x, y = pos
    if self[pos].nil?
      "   ".colorize(background: :red)
    else
      piece = self[pos]

      " #{piece.display.colorize(color: piece.color)} "
        .colorize(background: :red)
    end
  end

  def move(start_pos, end_pos)
    raise NoPieceError.new("No piece there.") if self[start_pos].nil?
    piece = self[start_pos]
    raise IllegalMoveError.new("Not a legal move.") if !piece.moves.include?(end_pos)
    raise IntoCheckError.new("Can't move into check.") if !piece.valid_moves.include?(end_pos)

    if self[start_pos].is_a?(King) && self[start_pos].castling_moves.include?(end_pos)
      castle(start_pos, end_pos)
    else
      move!(start_pos, end_pos)
    end
    
  end

  def castle(start_pos, end_pos)
    king = self[start_pos]
    row = start_pos[0]
    start_col, end_col = start_pos[1], end_pos[1]
    if end_col > start_col   #kingside castle
      rook = king.get_rook([row, start_col + 1])
      move!(king.pos, end_pos)
      move!(rook.pos, [row, start_col + 1]) 
    else                    #queenside castle
      rook = king.get_rook([row, start_col - 1])
      move!(king.pos, end_pos)
      move!(rook.pos, [row, start_col - 1]) 
    end

  end

  def move!(start_pos, end_pos)
    piece = self[start_pos]
    self[start_pos] = nil
    self[end_pos] = piece
    piece.pos = end_pos
    piece.moved = true
    # self.inspect
  end


  def parse(input)
    #input is like 'e5'
    input_array = input.split('')
    x, y = input_array[0].upcase.to_sym , input_array[1].to_i
    pos_x, pos_y = LETTER_MAPPING[x], NUMBER_MAPPING[y]
    [pos_x, pos_y]
  end

  def pieces(color)
    pieces = @grid.flatten.compact
    pieces.select{|piece| piece.color == color}
  end

  def show_board
    system("clear")
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

    numbers = (1..8).to_a.reverse
    board_display_array.each{|row| puts "#{numbers.shift} #{row}"}
    puts "   a  b  c  d  e  f  g  h "
  end


private
  # [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
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


if __FILE__ == $PROGRAM_NAME
  board = Board.new
  duped_board = board.dup
  duped_board.move([6,3], [4,3])
  p "original board"
  p board
  p "duped board"
  duped_board.move([1,4], [2,4])
  p duped_board
  duped_board.move([0,5], [4,1])
binding.pry
  duped_board.in_check?(:white)
end
