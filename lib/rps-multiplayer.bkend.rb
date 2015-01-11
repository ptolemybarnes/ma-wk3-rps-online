require 'rps-rounds.bkend'

class RpsMultiplayer
  attr_accessor :player_list, :moves
  attr_reader   :game

  def initialize
    @player_list = []
    @moves       = []
  end

  def add_player(name)
    player_list << name
  end

  def start_game(rounds)
    @game = RockPaperScissorRounds.new(player_list)
    @game.playgame(rounds)
  end

  def ready?
    moves.size == player_list.size
  end

  def play_round
    game.play_round(moves.to_h)
  end

  def clear_moves
    moves.clear
  end

  def clear_players
    player_list.clear
  end

end