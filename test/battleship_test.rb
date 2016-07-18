require 'minitest/autorun'
require 'minitest/pride'
require './lib/battleship'
#
# class GameTest < Minitest::Test
#   def test_
# end

class PlayerTest < Minitest::Test
  def test_it_exists
    p = Battleship::Player.new
    assert p
  end

  def test_it_starts_with_a_board
    p = Battleship::Player.new
    assert p.board
  end
end




class BoardTest < Minitest::Test
  def test_it_exists
    b = Battleship::Board.new
    assert b
  end

  def test_it_starts_with_4x4_grid_by_default
    b = Battleship::Board.new
    assert_equal [[0]*4]*4, b.grid
  end

  def test_it_can_start_with_8x8_grid
    b = Battleship::Board.new(8)
    assert_equal [[0]*8]*8, b.grid
  end
end


class ShipTest < Minitest::Test
  def test_it_exists
    s = Battleship::Ship.new(2)
    assert s
  end

  def test_it_can_be_various_sizes
    s = Battleship::Ship.new(3)
    assert 3, s.size
    assert 4, Battleship::Ship.new(4).size
  end
end



class GameTest < Minitest::Test
  def test_it_exists
    g = Battleship::Game.new
    assert g
  end

  def test_beginner_settings_on_by_default
    g = Battleship::Game.new
    assert 4, g.size
    assert [2,3], g.ships
    assert [Battleship::Ship.new(2), Battleship::Ship.new(3), g.player_1.ships]
  end

end
