class Board
  LETTER_MAPPING = {
    A: 0,
    B: 1,
    C: 2,
    D: 3,
    E: 4,
    F: 5,
    G: 6,
    H: 7
  }

  NUMBER_MAPPING = {
    1 => 7,
    2 => 6,
    3 => 5,
    4 => 4,
    5 => 3,
    6 => 2,
    7 => 1,
    8 => 0
  }


  def initialize
    @grid = Array.new(8) { Array.new(8) }
    set_board
  end

  def [](x, y)
    @grid[x][y]
  end

  def parse(input)
    #input is like 'e5'
    input_array = input.split('')
    x, y = input_array[0].upcase.to_sym , input_array[1].to_i
    pos_x, pos_y = LETTER_MAPPING[x], NUMBER_MAPPING[y]
    [pos_x, pos_y]
  end

  

end
