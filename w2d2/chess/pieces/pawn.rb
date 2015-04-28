require_relative 'piece.rb'


class Pawn < Piece
  def initialize(options)
    super
    @display = (@color == :white) ? "♙" : "♟"
  end

end
