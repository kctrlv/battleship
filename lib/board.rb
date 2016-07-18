module Battleship
  class Board
    attr_reader :grid

    def initialize(board_sides=4)
      @grid = make_grid(board_sides)
    end

    def make_grid(sides)
      [[0] * sides] * sides
    end
  end
end
