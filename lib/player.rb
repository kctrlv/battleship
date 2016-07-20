require './lib/ship'
require './lib/grid'
require './lib/placement_validator'

class Player
  attr_reader :personal_grid, :opponent_grid, :ships

  def initialize(size=4, ships=[2,3]) #int, array
    @ships = Ship.make_ships(ships)
    @personal_grid = Grid.new(size)
    @opponent_grid = Grid.new(size)
  end

  def place_ship(ship, coord_1, coord_2)
    validator = PlacementValidator.new(grid=@personal_grid, ship, coord_1, coord_2)
    if validator.valid?
      @personal_grid.place_ship(ship, coord_1, coord_2)
    else
      validator.explain_why_invalid
    end
  end
end
