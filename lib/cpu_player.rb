require './lib/player'

class CPU_Player < Player


  def place_ships
    ships.each{ |ship| cpu_place_ship(ship) }
  end

  def determine_placement_coords(ship, horizontal)
    x1 = x2 = Array(0..grid_size - ship.size).sample
    y1 = Array(0..grid_size - ship.size).sample
    y2 = y1 + ship.size - 1
    x1, y1 = y1, x1 if !horizontal
    x2, y2 = y2, x2 if !horizontal
    # puts x1, y1, x2, y2
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
    if result.class == Array
      cpu_place_ship(ship)
    end
  end

  def get_random_coord
    Array("A".."Z")[Array(0...grid_size).sample]+Array(1..grid_size).sample.to_s
  end

  def cpu_fire(opponent)
    coord = get_random_coord
    puts "Firing at #{coord}"
    result = fire_upon(opponent, coord)
    until [Message.hit!, Message.missed].include?(result)
      cpu_fire(opponent)
    end

    result
  end
end
#
#
# $player1 = Player.new
# $player2 = CPU_Player.new
#
# $player1.place_ship($player1.ships[0], "A1", "A2")
# $player1.place_ship($player1.ships[1], "B1", "B3")
#
# $player1.show_personal_grid
#
# $player2.show_personal_grid
#
# $player2.place_ships
#
# $player2.show_personal_grid
