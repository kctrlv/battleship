module Battleship
  class Ship
    attr_reader :size

    def initialize(ship_size)
      @size = ship_size
    end

    def self.make_ships(ships)
      ships.map{|ship| self.new(ship)}
    end
  end
end
