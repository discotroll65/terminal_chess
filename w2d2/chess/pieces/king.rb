require_relative 'piece.rb'

class King < SteppingPiece
  MOVE_DIRS = [
  [-1, -1],
  [-1,  0],
  [-1,  1],
  [ 0, -1],
  [ 0,  1],
  [ 1, -1],
  [ 1,  0],
  [ 1,  1]
]
  def initialize(options)
    super
    @display = (@color == :white) ? "♔" : "♚"
  end

end
