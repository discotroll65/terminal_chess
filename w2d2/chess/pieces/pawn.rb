require_relative 'piece.rb'

class Pawn < Piece
  attr_accessor :en_passant_danger
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
    @en_passant_danger = false
  end

  def attack_moves
    attacks = self.color == :white ? WHITE_ATTACKS : BLACK_ATTACKS
    useable_dirs = attacks.select do |dir|
      test_pos = add_vector(self.pos , dir)
      can_attack?(test_pos)
    end
    useable_dirs.map{|dir| add_vector(self.pos, dir) }
  end

  def can_attack?(pos)
    normal_attack = !@board[pos].nil? &&
      @board[pos].color != @color && on_board?(pos)
    normal_attack || making_en_passant?(pos)
  end

  def making_en_passant?(pos)
    if (@color == :white)
      dead_pawn_pos = add_vector(pos, BLACK_SLIDES.last)
      test_piece = board[dead_pawn_pos]
      test_piece.is_a?(Pawn) && test_piece.color == :black &&
        test_piece.en_passant_danger
    else
      dead_pawn_pos = add_vector(pos, WHITE_SLIDES.last)
      test_piece = board[dead_pawn_pos]
      test_piece.is_a?(Pawn) && test_piece.color == :white &&
        test_piece.en_passant_danger
    end
  end

  def moves
    slide_moves + attack_moves
  end

  def making_two_hop?(end_pos)
    if (@color == :white)
      end_pos == add_vector(self.pos, WHITE_SLIDES.first)
    else
      end_pos == add_vector(self.pos, BLACK_SLIDES.first)
    end
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
