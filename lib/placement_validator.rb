require './lib/message'

class PlacementValidator
  attr_reader :grid, :ship, :c1, :c2

  def initialize(grid, ship, begin_coord, end_coord)
    @grid = grid
    @ship = ship
    @c1 = begin_coord
    @c2 = end_coord
  end

  def get_actual_coords #helper
    if c1[0]==c2[0]
      Array(c1..c2)
    else
      Array(c1.reverse..c2.reverse).map{ |c| c.reverse }
    end
  end

  def lookup(coord)
    grid.lookup(coord)
  end

  def length_of_coord_range
    row1, col1 = grid.translate_coord_to_2d_index(c1)
    row2, col2 = grid.translate_coord_to_2d_index(c2)
    ((row2 - row1).abs - (col2 - col1).abs).abs + 1
  end

  def coords_straight?
    c1.chars.zip(c2.chars).any?{ |z| z[0]==z[1] }
  end

  def coords_match_length?
    ship.size == length_of_coord_range
  end

  def actual_coords
    get_actual_coords if coords_straight? && coords_match_length?
  end

  def coords_unoccupied?
    actual_coords.all?{ |coord| lookup(coord)==' ' }
  end

  def coords_in_range?
    actual_coords.all?{ |coord| !!lookup(coord) }
  end


  def valid?
    coords_straight?      &&
    coords_match_length?  &&
    coords_unoccupied?    &&
    coords_in_range?
  end

  def explain_why_invalid
    errors = []
    errors << Message.invalid_placement
    errors << Message.not_straight if !coords_straight?
    errors << Message.not_match_length if !coords_match_length? && coords_straight?
    errors << Message.not_unoccupied if actual_coords && coords_in_range? && !coords_unoccupied?
    errors << Message.not_in_range if actual_coords && !coords_in_range?
    errors << Message.please_try_again
    errors
  end




end
