require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'

class GameTest < Minitest::Test
  def test_it_exists
    g = Game.new
    assert g
  end

  def test_beginner_settings_on_by_default
    g = Game.new
    assert_equal 4, g.size
    assert_equal [2,3], g.ships
  end

  
end
