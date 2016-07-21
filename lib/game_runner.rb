require './lib/message'
require './lib/game'

class GameRunner
  attr_reader :game, :endgame

  def initialize
    @game = nil
    @endgame = nil
  end

  def clear
    system 'clear'
  end

  def prompt(msg)
    print msg
    gets.chomp
  end

  def prompt_helper(prompt_msg, sleep_time=1, prev_msg=nil, clr=true)
    clear if clr
    print prev_msg if prev_msg
    sleep(sleep_time)
    prompt(prompt_msg)
  end

  def prompt_play(sleep_time=1, prev_msg=nil)
    answer = prompt_helper(Message.start, sleep_time, prev_msg)
    prompt_play_handler(answer)
  end

  def prompt_play_handler(answer)
    case answer
    when 'q'
      print Message.quitter
    when 'i'
      prompt_play(2.5, Message.instructions)
    when 'p'
      proceed_play
    else
      prompt_play(1.5, Message.qip)
    end
  end

  def start
    clear
    prompt_play(1, Message.welcome)
  end

  def proceed_play
    clear
    @game = Game.new
    game.cpu_place_ships
    game.cpu_done_messages
    prompt_placement_multiple(game.ships)
  end

  def prompt_placement_multiple(ships)
    ships.each { |ship| prompt_placement(ship) }
    show_grid(own=true, 3)
    proceed_game_flow
  end

  def show_grid(own=false, post_sleep=1)
    sleep(1)
    clear
    if own
      print Message.heres_your_grid
      game.player_1.show_personal_grid
    else
      print Message.heres_their_grid
      game.player_1.show_opponent_grid
    end
    sleep(post_sleep)
  end



  def prompt_placement(ship, prev_msg = nil)
    msg = Message.prompt_placement(ship)
    answer = prompt_helper(msg, 1, prev_msg, false)
    prompt_placement_handler(answer, ship)
  end

  def is_coord?(x)
    return false if x.class  != String
    return false if x.length != 2
    return false if !Array("A".."Z").include?(x[0])
    return false if x[1].to_i < 1
    true
  end

  def validate_placement(answer) #returns coords
    return false if answer.length != 5
    return false if answer[2] != ' '
    c1, c2 = answer.upcase.split
    return false if !is_coord?(c1) || !is_coord?(c2)
    [c1, c2]
  end

  def prompt_placement_handler(answer, ship)
    coords = validate_placement(answer)
    if coords
      #puts "Your coords #{coords} are actual coords but are they valid?"
      result = game.player_1.place_ship(Ship.new(ship), coords[0], coords[1])
      prompt_placement(ship, result.join("")) if result.class == Array
      print Message.nice_job_placing if result == true
    else
      prompt_placement(ship, Message.coord_instructions)
    end
  end

  def prompt_fire(prev_msg=nil, sleep_time=1, clear=false)
    msg = Message.fire_away
    answer = prompt_helper(msg, sleep_time=1, prev_msg, clr=false)
    prompt_fire_handler(answer)
  end

  def prompt_fire_handler(answer)
    coord = answer.upcase
    if is_coord?(coord)
      result = game.player_1.fire_upon(game.player_2, coord)
      prompt_fire_result_handler(result)
    else
      prompt_fire(Message.no_such_coordinate)
    end
  end

  def prompt_fire_result_handler(result)
    case result
    when Message.internal_trigger_endgame
      @endgame = true
    when Message.missed
      print Message.missed
    when Message.already_missed
      prompt_fire(Message.already_missed, 1)
    when Message.already_hit
      prompt_fire(Message.already_hit, 1)
    when Message.invalid_coordinate
      prompt_fire(Message.invalid_coordinate, 1)
    when Message.hit!
      print Message.hit!
      sleep(1.5)
    end
  end

  def prompt_enter
    prompt(Message.enter)
  end

  def prompt_player1_shot_sequence
    show_grid(own=false, 0)
    prompt_fire
    show_grid
    prompt_enter
  end



  def prompt_player2_shot_sequence
    result = game.player_2.cpu_fire(game.player_1)
    print result
    show_grid(true)
  end

  def proceed_game_flow
    @endgame = false
    while !endgame
      prompt_player1_shot_sequence
      prompt_player2_shot_sequence if !endgame
    end
    proceed_endgame
  end

  def proceed_endgame
    if game.player_1.ships_remain?
      print Message.you_win
      print Message.player_shots(game.player_1.shots)
      # print "It took you #{game.player_1.shots} shots!"
    else
      print Message.you_lose
      print Message.computer_shots(game.player_2.shots)
      # print "It took the computer #{game.player_2.shots} shots"
    end
    print Message.time(Time.now - game.time)
    # print "The game lasted #{game.time - Time.now}"
    sleep(3)
    exit
  end


end



g = GameRunner.new
g.start
