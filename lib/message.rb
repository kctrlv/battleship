module Message
  def self.welcome
    "Welcome to BATTLESHIP\n"
  end

  def self.start
    "Would you like to (p)lay, read the (i)nstructions, or (q)uit?\n> "
  end

  def self.quitter
    "kthxbye\n"
  end

  def self.qip
    "I only understand three letters right now...\n\n"
  end

  def self.instructions
    "Try to sink your enemy's ships before they sink yours.\nIt's easy to learn as you go along.\n\n"
  end

  def self.cpu_placed_laid_out
    "I have laid out my ships on the grid.\n"
  end

  def self.num_to_word(num)
    ['zero','one','two','three','four'][num]

  end

  def self.cpu_placed_now_you(num_ships)
    "You now need to layout your #{num_to_word(num_ships)} ships.\n"
  end

  def self.cpu_placed_your_first(size)
    "The first is #{num_to_word(size)} units long and the\n"
  end

  def self.cpu_placed_your_second(size)
    "second is #{num_to_word(size)} units long.\n"
  end

  def self.cpu_placed_the_grid(size)
    row = Array("A".."Z")[size-1]
    "The grid has A1 at the top left and #{row+size.to_s} at the bottom right.\n\n"
  end

  def self.prompt_placement(ship)
    "Enter the coordinates for the #{num_to_word(ship)}-unit ship: \n> "
  end

  def self.coord_instructions
    "Try again. Enter two coordinates seperated by a space.\n"
  end

  def self.nice_job_placing
    "Good work, that ship is officially placed.\n"
  end

  def self.heres_your_grid
    "Check it out, this is your grid: \n\n"
  end

  def self.heres_their_grid
    "Here's what you know about their grid.\n"
  end

  def self.fire_away
    "Take aim, and fire!\n> "
  end

  def self.no_such_coordinate
    "That ain't no coordinate I ever heard of.\n"
  end

  def self.internal_trigger_endgame
    "TRIGGER_END"
  end

  def self.enter
    "Press enter to continue.\n"
  end

  def self.you_lose
    "Sorry! You lost.\n"
  end

  def self.you_win
    "Congratulations! You win!\n"
  end

  def self.player_shots(shots)
    "It took you #{shots} shots\n"
  end

  def self.computer_shots(shots)
    "It took the computer #{shots} shots\n"
  end

  def self.time(duration)
    "The game lasted for #{duration} seconds"
  end



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
    "Splash! Missed!\n"
  end

  def self.invalid_coordinate
    "Hey, your shot was off the board!\n"
  end

  def self.already_missed
    "You already missed this spot before, I won't let you waste a turn comrade!\n"
  end

  def self.hit!
    "Hit!\n"
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
