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

  def moves
    regular_moves = super
    regular_moves + castling_moves(regular_moves)
  end

  def castling_moves(regular_moves)
    return [] if @moved
    one_hops = king_moves_on_same_row(regular_moves)
    return [] if one_hops.empty?
    candidate_onehops = one_hops.select do |onehop|
       row_clear?(onehop)
    end
    return [] if candidate_onehops.empty?
    two_hops = get_two_hops(candidate_onehops)
    two_hops.reject{|two_hop| move_into_check?(two_hop) }
  end

  def king_moves_on_same_row(regular_moves)
    regular_moves.select {|move| move[0] == self.pos[0]}
  end

  def row_clear?(onehop)
    return false unless rook_hasnt_moved?(onehop)
    rook = get_rook(onehop)
    rook.moves.include?(onehop)
  end

  def get_two_hops(one_hops)
    one_hops.map do |onehop|
      row, col = onehop
      (col > self.pos[1]) ? [row, col + 1] : [row, col - 1]
    end
  end

  def rook_hasnt_moved?(onehop)
    row, col = onehop
    if (col > self.pos[1])
      rook_space = board.grid[row].last
      !rook_space.nil? && !rook_space.moved?
    else
      rook_space = board.grid[row].first
      !rook_space.nil? && !rook_space.moved?
    end
  end

  def get_rook(onehop)
    row, col = onehop
    if (col > self.pos[1])
      rook = board.grid[row].last
    else
      rook = board.grid[row].first
    end
  end

end
