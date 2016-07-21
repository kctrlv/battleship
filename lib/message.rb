module Message
  def self.invalid_placement
    "Invalid Placement: \n"
  end
  def self.not_straight
    "Your coordinates are not in a horizontal or vertical placement.\n"
  end

  def self.not_match_length
    "Your coordinates do not match the size of the ship.\n"
  end

  def self.not_unoccupied
    "One or more squares in this area is already occupied by a ship.\n"
  end

  def self.not_in_range
    "One or more of your coordinates falls outside the grid.\n"
  end

  def self.please_try_again
    "Please try again.\n\n"
  end

  def self.cpu_placed_ships
    "I have laid out my ships on the grid.\nYou now need to layout your two ships.\nThe first is two units long and the\nsecond is three units long.\nThe grid has A1 at the top left and D4 at the bottom right.\n\nEnter the squares for the two-unit ship: "
  end

  def self.missed
    "Splash! You missed!\n"
  end

  def self.invalid_coordinate
    "Hey, your shot was off the board!\n"
  end

  def self.already_missed
    "You already missed this spot before, I won't let you waste a turn comrade!\n"
  end

  def self.hit!
    "It's a HIT! Keep up the pressure!\n"
  end

  def self.sunk(target)
    "YES! You sunk their #{self.ship_name(target)}! It was a size #{target} ship!"
  end

  def self.already_hit
    "You already hit this spot! No need to fire here again!\n"
  end

  def self.ship_name(target)
    case target
    when 2
      "Cruiser"
    when 3
      "Submarine"
    when 4
      "Battleship"
    when 5
      "Carrier"
    end
  end
end
