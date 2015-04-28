require_relative 'piece.rb'

class Bishop < SlidingPiece

  MOVE_DIRS = [
    [1, 1],
    [-1,-1],
    [1, -1],
    [-1, 1]
  ]

  def initialize(options)
    super
    @display = (@color == :white) ? "♗" : "♝"
  end

end
