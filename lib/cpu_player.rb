require './lib/player'

class CPUPlayer < Player
  def place_ships
    ships.each { |ship| cpu_place_ship(ship) }
  end

  def determine_placement_coords(ship, horizontal)
    x1 = x2 = Array(0..grid_size - ship.size).sample
    y1 = Array(0..grid_size - ship.size).sample
    y2 = y1 + ship.size - 1
    x1, y1 = y1, x1 unless horizontal
    x2, y2 = y2, x2 unless horizontal
    c1 = @personal_grid.translate_2d_index_to_coord([x1, y1])
    c2 = @personal_grid.translate_2d_index_to_coord([x2, y2])
    [c1, c2]
  end

  def attempt_placement(ship)
    horizontal = [true, false].sample
    result = determine_placement_coords(ship, horizontal)
    c1, c2 = result
    place_ship(ship, c1, c2)
  end

  def cpu_place_ship(ship)
    result = attempt_placement(ship)
    cpu_place_ship(ship) if result.class == Array
  end

  def random_coord
    row = Array('A'..'Z')[Array(0...grid_size).sample]
    col = Array(1..grid_size).sample.to_s
    row + col
  end

  def cpu_fire(opponent)
    coord = random_coord
    puts "Firing at #{coord}"
    result = fire_upon(opponent, coord)
    cpu_fire(opponent) until [Message.hit!, Message.missed].include?(result)
    result
  end
end
