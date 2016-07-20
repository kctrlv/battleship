require 'minitest/autorun'
require 'minitest/pride'
require './lib/placement_validator'
require './lib/grid'
require './lib/ship'

class PlacementValidatorTest < Minitest::Test
  def test_it_exists
    g = Grid.new
    s = Ship.new(2)
    p = PlacementValidator.new(g, s, "A1", "A2")
    assert p
  end

  def test_it_can_lookup_coordinate
    g = Grid.new
    g.assign("A3",2)
    s = Ship.new(2)
    p = PlacementValidator.new(g, s, "A1", "A2")
    assert_equal 2, p.lookup("A3")
    assert_equal 'w', p.lookup("A4")
    assert_equal nil, p.lookup("A5")
  end

  def test_it_can_validate_coords_are_straight
    p = PlacementValidator.new(Grid.new, Ship.new(2), "A1", "A2")
    assert_equal true, p.coords_straight?
    p = PlacementValidator.new(Grid.new, Ship.new(2), "B1", "A2")
    assert_equal false, p.coords_straight?
    p = PlacementValidator.new(Grid.new, Ship.new(2), "C1", "C2")
    assert_equal true, p.coords_straight?
    p = PlacementValidator.new(Grid.new, Ship.new(2), "D2", "D2")
    assert_equal true, p.coords_straight?
    p = PlacementValidator.new(Grid.new, Ship.new(2), "A1", "D1")
    assert_equal true, p.coords_straight?
    p = PlacementValidator.new(Grid.new, Ship.new(3), "C1", "E1")
    assert_equal true, p.coords_straight?

  end

  def test_it_can_determine_length_of_coords
    p = PlacementValidator.new(Grid.new, Ship.new(2), "A1", "A2")
    assert_equal 2, p.length_of_coord_range
    p = PlacementValidator.new(Grid.new, Ship.new(2), "B1", "B3")
    assert_equal 3, p.length_of_coord_range
    p = PlacementValidator.new(Grid.new, Ship.new(2), "A1", "A3")
    assert_equal 3, p.length_of_coord_range
    p = PlacementValidator.new(Grid.new, Ship.new(2), "B2", "D2")
    assert_equal 3, p.length_of_coord_range
    p = PlacementValidator.new(Grid.new, Ship.new(2), "B2", "C2")
    assert_equal 2, p.length_of_coord_range
    p = PlacementValidator.new(Grid.new, Ship.new(3), "C1", "E1")
    assert_equal 3, p.length_of_coord_range

  end

  def test_it_can_validate_length_of_ship_matches_coord_length
    p = PlacementValidator.new(Grid.new, Ship.new(2), "A1", "A2")
    assert_equal true, p.coords_match_length?
    p = PlacementValidator.new(Grid.new, Ship.new(3), "A1", "A3")
    assert_equal true, p.coords_match_length?
    p = PlacementValidator.new(Grid.new, Ship.new(3), "A3", "A1")
    assert_equal true, p.coords_match_length?
    p = PlacementValidator.new(Grid.new, Ship.new(2), "A1", "B1")
    assert_equal true, p.coords_match_length?
    p = PlacementValidator.new(Grid.new, Ship.new(3), "A1", "C1")
    assert_equal true, p.coords_match_length?
    p = PlacementValidator.new(Grid.new, Ship.new(2), "A1", "A3")
    assert_equal false, p.coords_match_length?
    p = PlacementValidator.new(Grid.new, Ship.new(4), "A1", "A2")
    assert_equal false, p.coords_match_length?
    p = PlacementValidator.new(Grid.new, Ship.new(3), "B1", "B2")
    assert_equal false, p.coords_match_length?
    p = PlacementValidator.new(Grid.new, Ship.new(3), "C1", "C4")
    assert_equal false, p.coords_match_length?
    p = PlacementValidator.new(Grid.new, Ship.new(3), "C1", "E1")
    assert_equal true, p.coords_match_length?

  end

  def test_it_can_determine_actual_coords
    p = PlacementValidator.new(Grid.new, Ship.new(2), "A1", "A2")
    assert_equal ['A1','A2'], p.actual_coords
    p = PlacementValidator.new(Grid.new, Ship.new(3), "A1", "A3")
    assert_equal ['A1','A2','A3'], p.actual_coords
    p = PlacementValidator.new(Grid.new, Ship.new(3), "A1", "C1")
    assert_equal ['A1','B1','C1'], p.actual_coords
    p = PlacementValidator.new(Grid.new, Ship.new(3), "C1", "E1")
    assert_equal ['C1','D1','E1'], p.actual_coords
  end

  def test_it_can_validate_coords_unoccupied
    p = PlacementValidator.new(Grid.new, Ship.new(3), "A1", "A3")
    assert_equal true, p.coords_unoccupied?
    p.grid.assign("A2", 2)
    assert_equal false, p.coords_unoccupied?
    p = PlacementValidator.new(Grid.new, Ship.new(2), "A5", "A6")
    assert_equal false, p.coords_unoccupied?
  end

  def test_it_can_validate_coords_in_range
    p = PlacementValidator.new(Grid.new, Ship.new(3), "A1", "A3")
    assert_equal true, p.coords_in_range?
    p = PlacementValidator.new(Grid.new, Ship.new(3), "B1", "B3")
    assert_equal true, p.coords_in_range?
    p = PlacementValidator.new(Grid.new, Ship.new(3), "B2", "B4")
    assert_equal true, p.coords_in_range?
    p = PlacementValidator.new(Grid.new, Ship.new(3), "C1", "E1")
    assert_equal false, p.coords_in_range?
  end

  def test_it_validates_properly
    assert PlacementValidator.new(Grid.new, Ship.new(3), "A1", "A3").valid?
    assert PlacementValidator.new(Grid.new, Ship.new(4), "A1", "A4").valid?
    assert PlacementValidator.new(Grid.new, Ship.new(2), "A1", "B1").valid?
    assert PlacementValidator.new(Grid.new, Ship.new(2), "B1", "B2").valid?
    assert PlacementValidator.new(Grid.new, Ship.new(3), "D1", "D3").valid?
    refute PlacementValidator.new(Grid.new, Ship.new(3), "A1", "A4").valid?
    refute PlacementValidator.new(Grid.new, Ship.new(3), "A1", "A4").valid?
    refute PlacementValidator.new(Grid.new, Ship.new(2), "A1", "B2").valid?
    refute PlacementValidator.new(Grid.new, Ship.new(2), "B1", "B5").valid?
    refute PlacementValidator.new(Grid.new, Ship.new(3), "D3", "D6").valid?
  end




end
