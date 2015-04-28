require_relative 'piece.rb'


class Queen < SlidingPiece

  MOVE_DIRS = [
    [1, 1],
    [-1,-1],
    [1, -1],
    [-1, 1],
    [0,1],
    [0,-1],
    [1, 0],
    [-1,0]
  ]

  def initialize(options)
    super
    @display = (@color == :white) ? "♕" : "♛"
  end

end
