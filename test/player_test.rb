require 'minitest/autorun'
require 'minitest/pride'
require './lib/player'

class PlayerTest < Minitest::Test
  def test_it_exists
    p = Player.new
    assert p
  end

  def test_it_starts_with_set_of_grids
    assert Player.new.personal_grid
    assert Player.new.opponent_grid
  end

  def test_it_starts_with_set_of_ships
    assert Player.new.ships.all?{|item| item.class == Ship}
  end

  def test_it_can_place_a_ship_on_its_grid
    p = Player.new
    ship_to_place = p.ships[0]
    assert p.place_ship(ship_to_place, "A1", "B1")
  end

  def test_one_player_can_hit_another_player
    player1 = Player.new
    player2 = Player.new
    player1.place_ship(player1.ships[0], "A1", "A2")
    player1.place_ship(player1.ships[1], "B1", "B3")
    player2.place_ship(player2.ships[0], "A3", "B3")
    player2.place_ship(player2.ships[1], "A4", "C4")
    refute player1.fire_upon(player2, "A2")
    assert player1.fire_upon(player2, "A3")
    assert player2.fire_upon(player1, "A1")
    refute player2.fire_upon(player1, "A4")
  end


end
