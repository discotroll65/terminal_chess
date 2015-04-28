require_relative 'piece.rb'

class King < SteppingPiece
  DELTAS = [
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
