require_relative 'rps-rounds.bkend'

class RpsMultiplayer
  attr_accessor :player_list, :moves, :round_num, :game_in_progress, :player_cap
  attr_reader   :game

  def initialize
    @player_list      = []
    @moves            = []
    @game_in_progress = false
  end

  def add_player(name)
    player_list << name
  end

  def game_ready?
    player_list.size >= player_cap
  end

  def start_game
    @game = RockPaperScissorRounds.new(player_list)
    @game.playgame(round_num)
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

  def sudden_death?
    (game.score.values.max >= game.rounds_total) and game.tie?
  end

  def player_count
    player_list.size
  end

end