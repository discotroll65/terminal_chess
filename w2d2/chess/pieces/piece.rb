require_relative 'bishop.rb'
require_relative 'knight.rb'
require_relative 'rook.rb'
require_relative 'king.rb'
require_relative 'pawn.rb'
require_relative 'queen.rb'


class Piece
  attr_reader :color, :pos, :moved, :display

  def initialize(options)
    @pos = options[:pos]
    @color = options[:color]
    @board = options[:board]
    @moved = false
  end

  def moves
     raise "Method not yet defined in pieces.rb"
  end

  def valid_move?
     raise "Method not yet defined in pieces.rb"
  end
end

class SlidingPiece < Piece
  attr_reader :move_powers


end

class SteppingPiece < Piece

end
