require_relative 'board.rb'

class Chess
  attr_reader :player_white, :player_black, :board

  def initialize(options)
    @board = Board.new
    @player_white = options[:white]
    @player_black = options[:black]
    @players = [0, @player_white, @player_black]
    @current_player = @player_white
  end

  def play
    turn = 1
    board.inspect

    until @board.in_check_mate?(@current_player.color)
      input = @current_player.get_move
      pos = parse_input(input)

      begin
        board.move(pos)
      rescue ChessError => e
        e.message
        retry
      end

      turn *= -1
      @current_player = @players[turn]
      board.inspect
    end

    winner = @players[(turn *= 1)]

    puts "Checkmate!"
    puts "#{winner.color}.capitalize wins!"

  end





end


# get options from user
# initialize chess game with options provided


if __FILE__ == $PROGRAM_NAME
  # get user options
  # initiailize standard chess class with options
end
