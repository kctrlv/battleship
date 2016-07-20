require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test
  def test_it_exists
    s = Ship.new(2)
    assert s
  end

  def test_it_can_be_various_sizes
    s = Ship.new(3)
    assert 3, s.size
    assert 4, Ship.new(4).size
  end
end
