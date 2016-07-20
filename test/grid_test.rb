require 'minitest/autorun'
require 'minitest/pride'
require './lib/grid'

class GridTest < Minitest::Test
  def test_it_exists
    g = Grid.new
    assert g
  end

  def test_it_starts_with_4x4_grid_by_default
    g = Grid.new
    assert_equal [['w']*4]*4, g.grid
    assert_equal 4, g.size
  end

  def test_it_can_start_with_8x8_grid
    g = Grid.new(8)
    assert_equal [['w']*8]*8, g.grid
    assert_equal 8, g.size
  end

  def test_it_can_assign_and_lookup_values
    g = Grid.new
    assert_equal 'w', g.lookup("A1")
    g.assign("A1", 2)
    assert_equal 2, g.lookup("A1")
    assert_equal 'w', g.lookup("B1")
  end

  # def test_it_can_render_grid
  #   skip
  #   b = Battleship::Board.new
  #   b.render_grid
  # end
  #
  # def test_it_can_render_8x8_grid
  #   skip
  #   Battleship::Board.new(8).render_grid
  # end




end
