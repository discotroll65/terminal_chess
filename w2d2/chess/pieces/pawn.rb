require_relative 'piece.rb'

class Pawn < Piece
  WHITE_SLIDES = [
    [-2, 0],
    [-1, 0]
  ]

  WHITE_ATTACKS = [
    [-1, 1],
    [-1, -1]
  ]

  BLACK_SLIDES = [
    [2, 0],
    [1, 0]
  ]

  BLACK_ATTACKS = [
    [1, -1],
    [1, 1]
  ]

  def initialize(options)
    super
    @display = (@color == :white) ? "♙" : "♟"
  end

  def attack_moves
    if (@color == :white)
      useable_dirs = WHITE_ATTACKS.select do |dir|
        test_pos = add_vector(self.pos , dir)
        can_attack?(test_pos)
      end

      useable_dirs.map{|dir| add_vector(self.pos, dir) }
    else
      usable_dirs = BLACK_ATTACKS.select do |dir|
        test_pos = add_vector(self.pos , dir)
        can_attack?(test_pos)
      end
      useable_dirs.map{|dirs| add_vector(self.pos, dir) }
    end
  end

  def can_attack?(pos)
    !@board[pos].nil? && @board[pos].color != @color
  end

  def moves
    slide_moves + attack_moves
  end

  def slide_moves
    if (@color == :white)
      one_hop = add_vector(self.pos, WHITE_SLIDES.last)
      two_hop = add_vector(self.pos, WHITE_SLIDES.first)
      slide_checks(one_hop, two_hop)
    else
      one_hop = add_vector(self.pos, BLACK_SLIDES.last)
      two_hop = add_vector(self.pos, BLACK_SLIDES.first)
      slide_checks(one_hop, two_hop)
    end
  end

  def slide_checks(one_hop, two_hop)
    available_moves = []
    if valid_move?(one_hop)
      available_moves << one_hop
      if valid_move?(two_hop) && !moved?
        available_moves << two_hop
      end
    end

    available_moves
  end

  def valid_move?(pos)
     on_board?(pos) && @board[pos].nil?
  end

end
