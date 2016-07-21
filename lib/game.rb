require './lib/player'
require './lib/cpu_player'

class Game
  attr_reader :player_1, :player_2, :size, :ships, :time

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
    @player_2 = CPU_Player.new(size, ships)
    @time = Time.now
  end

  def cpu_place_ships
    @player_2.place_ships
  end

  def cpu_done_messages
    print Message.cpu_placed_laid_out
    print Message.cpu_placed_now_you(ships.length)
    print Message.cpu_placed_your_first (ships[0]) if ships[0]
    print Message.cpu_placed_your_second(ships[1]) if ships[1]
    print Message.cpu_placed_your_third (ships[2]) if ships[2] #EXTENSION
    print Message.cpu_placed_your_fourth(ships[3]) if ships[3] #EXTENSION
    print Message.cpu_placed_the_grid(size)
  end



end
