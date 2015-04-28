class Piece
  attr_reader :color, :pos, :moved, :display

  def initialize(options)(options)
    @pos = options[:pos]
    @color = options[:color]
    @board = options[:board]
    @moved = false
  end

end

class SlidingPiece < Piece

end

class SteppingPiece < Piece

end

class Rook < SlidingPiece

  def initialize(options)
    super
    @display =  (@color == :white) ?  "♖" : "♜"
  end

end


class Queen < SlidingPiece
  def initialize(options)
    super
    @display = (@color == :white) ? "♕" : "♛"
  end

end

class Bishop < SlidingPiece
  def initialize(options)
    super
    @display = (@color == :white) ? "♗" : "♝"
  end

end



class Pawn < Piece
  def initialize(options)
    super
    @display = (@color == :white) ? "♙" : "♟"
  end

end

class King < SteppingPiece
  def initialize(options)
    super
    @display = (@color == :white) ? "♔" : "♚"
  end

end

class Knight < SteppingPiece
  def initialize(options)
    super
    @display = (@color == :white) ? "♘" : "♞"
  end

end
