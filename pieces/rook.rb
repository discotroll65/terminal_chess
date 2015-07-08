require_relative 'piece.rb'

class Rook < SlidingPiece

  MOVE_DIRS = [
    [0,1],
    [0,-1],
    [1, 0],
    [-1,0]
  ]

  def initialize(options)
    super
    @display =  (@color == :white) ?  "♖" : "♜"
  end

end
