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

  def inspect
    {
      display: @display,
      pos: @pos,
      moved: @moved,
      color: @color
    }
  end

  def moves
     raise "Method not yet defined in pieces.rb"
  end

  def valid_move?(pos)
     on_board?(pos) &&
      (@board[pos].nil? || @board[pos].color != @color)
  end

  def on_board?(pos)
    x, y = pos
    x.between?(0,7) && y.between?(0,7)
  end
end

class SlidingPiece < Piece

  def moves
    available_moves = []

    MOVE_DIRS.each do |dir|
      (1..7).each do |slide_amount|
        move_vector = multiply_vector(dir, slide_amount)
        test_pos = add_vector(self.pos , move_vector )

        if valid_move?( test_pos  )
          available_moves << test_pos
          break if board[test_pos] # captured other piece
        else
          break
        end
      end
    end
    available_moves

  end

  def add_vector(pos, dir)
    pos.zip(dir).map{ |x,y| x + y }
  end

  def multiply_vector(dir, slide_amount)
    dir.map{|x, y| [x * slide_amount, y * slide_amount] }
  end



end

class SteppingPiece < Piece

end
