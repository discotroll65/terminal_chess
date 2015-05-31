require_relative 'player.rb'
class HumanPlayer < Player

    def get_move
      puts "#{self.color.to_s.capitalize}, enter chess notation of
            piece to move"
      print ">>"
      start_pos = gets.chomp

      puts "#{self.color.to_s.capitalize}, enter chess notation for
            destination square"
      print ">>"
      end_pos = gets.chomp
      [start_pos, end_pos]
    end

end
