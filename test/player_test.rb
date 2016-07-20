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

  def test_player_gets_correct_invalid_message_when_placing_ship_wrongly
    p = Player.new
    ship = p.ships[0]
    invalid_msgs = p.place_ship(ship, "A1", "A3")
    assert_equal "wrong length", invalid_msgs[0]
    invalid_msgs = p.place_ship(ship, "A1", "B2")
    assert_equal "not straight", invalid_msgs[0]
    invalid_msgs = p.place_ship(ship, "A5", "A6")
    assert_equal "falls off map", invalid_msgs[0]
    p.personal_grid.assign("A1", 2)
    invalid_msgs = p.place_ship(ship, "A1", "A2")
    assert_equal "spot occupied", invalid_msgs[0]
  end

  def test_it_can_place_a_ship_on_its_grid
    p = Player.new
    ship_to_place = p.ships[0]
    assert p.place_ship(ship_to_place, "A1", "B1")
    invalid_msgs = p.place_ship(ship_to_place, "A1", "B1")
    assert_equal "spot occupied", invalid_msgs[0]

  end
end
