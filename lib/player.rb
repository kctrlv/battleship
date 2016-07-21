require './lib/ship'
require './lib/grid'
require './lib/placement_validator'
require './lib/message'

class Player
  attr_reader :personal_grid, :opponent_grid, :ships, :ship_types, :grid_size

  def initialize(size=4, ships=[2,3]) #int, array
    @grid_size = size
    @ship_types = ships
    @ships = Ship.make_ships(ships)
    @personal_grid = Grid.new(size)
    @opponent_grid = Grid.new(size)
  end

  def show_personal_grid
    @personal_grid.render_grid
  end

  def show_opponent_grid
    @opponent_grid.render_grid
  end

  def place_ship(ship, coord_1, coord_2)
    validator = PlacementValidator.new(grid=@personal_grid, ship, coord_1, coord_2)
    if validator.valid?
      @personal_grid.place_ship(ship, coord_1, coord_2)
    else
      validator.explain_why_invalid
    end
  end

  def find_target(opponent, coord)
    opponent.personal_grid.lookup(coord)
  end

  def fire_upon(opponent, coord)
    target = find_target(opponent, coord)
    if target == ' '
      target_miss(coord)
    elsif target == 'M'
      puts Message.already_missed
    elsif target == 'H'
      puts Message.already_hit
    elsif target
      target_hit(opponent, coord, target)
    else
      puts Message.invalid_coordinate
    end
  end

  def target_miss(coord)
    puts Message.missed
    opponent_grid.assign(coord, 'M')
    false
  end

  def target_hit(opponent, coord, target)
    puts 'HIT!'
    opponent_grid.assign(coord, "H")
    #return true
    feedback = opponent.got_hit(coord, target) #return hit or sunk
    puts feedback
    if feedback == 'hit'
      puts Message.hit!
    elsif feedback == 'sunk'
      puts Message.sunk(target)
    end
    return true
  end

  def still_alive(target)
    @personal_grid.scan(target)
  end

  def got_hit(coord, target)
    personal_grid.assign(coord, "H")
    if still_alive(target)
      'hit'
    elsif !ships_remain?
      "lost"
    else
      'sunk'
    end
  end

  def ships_remain?
    ship_types.any?{ |ship| personal_grid.scan(ship)}
  end
end
