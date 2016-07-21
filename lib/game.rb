require './lib/player'

class Game
  attr_reader :player_1, :player_2, :size, :ships

  def determine_size_and_ships(game_difficulty)
    case game_difficulty
    when "beginner"
      size_and_ships = [4,[2,3]]
    when "intermediate"
      size_and_ships = [8,[2,3,4]]
    when "advanced"
      size_and_ships = [12,[2,3,4,5]]
    end
  end

  def initialize(difficulty='beginner') #|| "intermediate" || "advanced"
    @size, @ships = determine_size_and_ships(difficulty)
    @player_1 = Player.new(size, ships)
    @player_2 = Player.new(size, ships)
  end

  

end
