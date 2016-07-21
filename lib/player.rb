require './lib/ship'
require './lib/grid'
require './lib/placement_validator'
require './lib/message'

class Player
  attr_reader :personal_grid, :opponent_grid, :ships,
              :ship_types,    :grid_size,     :shots

  def initialize(size = 4, ships = [2, 3])
    @grid_size = size
    @ship_types = ships
    @ships = Ship.make_ships(ships)
    @personal_grid = Grid.new(size)
    @opponent_grid = Grid.new(size)
    @shots = 0
  end

  def show_personal_grid
    @personal_grid.render_grid
  end

  def show_opponent_grid
    @opponent_grid.render_grid
  end

  def place_ship(ship, coord_1, coord_2)
    v = PlacementValidator.new(@personal_grid, ship, coord_1, coord_2)
    if v.valid?
      @personal_grid.place_ship(ship, coord_1, coord_2)
    else
      v.explain_why_invalid
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
      Message.already_missed
    elsif target == 'H'
      Message.already_hit
    elsif target
      target_hit(opponent, coord, target)
    else
      Message.invalid_coordinate
    end
  end

  def target_miss(coord)
    opponent_grid.assign(coord, 'M')
    inc_shots
    Message.missed
  end

  def target_hit(opponent, coord, target)
    opponent_grid.assign(coord, 'H')
    inc_shots
    feedback = opponent.got_hit(coord, target) # return hit or sunk
    # puts feedback
    if feedback == 'hit'
      Message.hit!
    elsif feedback == 'sunk'
      puts Message.sunk(target)
      Message.hit!
    elsif feedback == 'lost'
      puts Message.hit!
      puts Message.sunk(target)
      Message.internal_trigger_endgame
    end
  end

  def inc_shots
    @shots += 1
  end

  def still_alive(target)
    @personal_grid.scan(target)
  end

  def got_hit(coord, target)
    personal_grid.assign(coord, 'H')
    if still_alive(target)
      'hit'
    elsif !ships_remain?
      'lost'
    else
      'sunk'
    end
  end

  def ships_remain?
    ship_types.any? { |ship| personal_grid.scan(ship) }
  end
end
