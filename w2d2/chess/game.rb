require_relative 'board.rb'
require_relative 'human_player.rb'
require 'pry'

class Chess

  CHESS_NOTATION_MAP = {
    A: 0,
    B: 1,
    C: 2,
    D: 3,
    E: 4,
    F: 5,
    G: 6,
    H: 7,
    8 => 0,
    7 => 1,
    6 => 2,
    5 => 3,
    4 => 4,
    3 => 5,
    2 => 6,
    1 => 7
  }

  attr_reader :player_white, :player_black, :board

  def initialize(options)
    @board = Board.new
    @player_white = options[:white]
    @player_black = options[:black]
    @players = [0, @player_white, @player_black]
    @current_player = @player_white
    @turn = 1
  end

  def play

    board.inspect

    until @board.in_check_mate?(@current_player.color)
      see_if_in_check
      begin
        make_chess_move
      rescue ChessError => e
        puts e.message
        retry
      end
      chang_turn
      board.inspect
    end
    show_winner
  end

  def change_turn
    @turn *= -1
    @current_player = @players[@turn]
  end

  def see_if_in_check
    puts "warning: #{@current_player.color.to_s}
        is in check!".upcase.red if board.in_check?(@current_player.color)
  end

  def make_chess_move(script = nil)
    input = script.nil? ? @current_player.get_move : script

    start_pos, end_pos = parse(input)
    raise NoPieceError.new("No piece there.") if board[start_pos].nil? 
    raise NotYourTurn.new("Not your turn, dude.") if
      board[start_pos].color != @current_player.color


    board.move(start_pos, end_pos)
  end

  def show_winner
    winner = @players[(@turn *= 1)]
    puts "Checkmate!"
    puts "#{winner.color.to_s.capitalize} wins!"
  end

  def parse(input)
    input.map do |note|
      letter, number = note.split('')
      col = CHESS_NOTATION_MAP[letter.upcase!.to_sym]
      row = CHESS_NOTATION_MAP[number.to_i]

      if [row, col].any? {|idx| !idx.is_a?(Fixnum) || !idx.between?(0,7) }
        raise NotChessNotation.new
      end
      [row, col]
    end
  end

end


# get options from user
# initialize chess game with options provided


if __FILE__ == $PROGRAM_NAME
  premade_moves = ARGV.shift
  options = {
    white: HumanPlayer.new(color: :white),
    black: HumanPlayer.new(color: :black)
    }
  game = Chess.new(options)

  game.play

  # get user options
  # initiailize standard chess class with options
end
