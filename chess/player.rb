class Player
  attr_reader :color

  def initialize(options)
    @color = options[:color]
  end

  def get_move
    raise "not defined yet"
  end

end
