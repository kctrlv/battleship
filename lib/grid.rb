require './lib/placement_validator'

class Grid
  attr_accessor :grid
  attr_reader :size

  def initialize(board_sides=4)
    @size = board_sides
    @grid = make_grid(board_sides)
  end

  def make_grid(sides)
    Array.new(sides){Array.new(sides,' ')}
    # array = [['w'] * sides] * sides
    # [['w','w','w','w'], ['w','w','w','w'],['w','w','w','w'],['w','w','w','w']]
  end

  def translate_coord_to_2d_index(coord)
    row = Array("A".."Z").join.index(coord[0])
    col = coord[1].to_i - 1
    [row, col]
  end

  def translate_2d_index_to_coord(index)
    row = Array("A".."Z")[index[0]]
    col = index[1] + 1
    row.to_s + col.to_s
  end

  def lookup(coord)
    row, col = translate_coord_to_2d_index(coord)
    grid[row][col] if [row,col].all?{ |x| x<size}
  end

  def assign(coord, value)
    row, col = translate_coord_to_2d_index(coord)
    grid[row][col] = value
  end

  def actual_coords(c1, c2)
    if c1[0]==c2[0]
      Array(c1..c2)
    else
      Array(c1.reverse..c2.reverse).map{ |c| c.reverse }
    end
  end

  def place_ship(ship, c1, c2)
    coords = actual_coords(c1, c2)
    coords.each{ |coord| assign(coord, ship.size)}
    true
  end

  def scan(target)
    grid.flatten.include?(target)
  end





  #ENEMY GRID METHODS - WILL DIVIDE LATER INTO SUBCLASSES

  def render_grid #WORKS ON UP TO 9x9 GRID
    size = @size
    cols = Array(1..size)
    letters = Array("A".."Z")
    rows = Array("A"...letters[size])

    puts "\n==" + ("=" * size * 2)
    puts ". #{cols.join(" ")}  "
    rows.each_with_index do |row, index|
      puts "#{row} #{grid[index].join(" ")}  "
    end
    puts "==" + ("=" * size * 2) + "\n"
  end


end
