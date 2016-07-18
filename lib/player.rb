module Battleship
  class Player
    attr_reader :board, :ships

    def initialize(size=4, ships=[2,3]) #int, array
      @ships = Ship.make_ships(ships)
      @board = Board.new(size)
    end
  end
end
