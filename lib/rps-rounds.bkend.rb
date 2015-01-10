require 'rps.bkend'


# Can play multi-round games of RPS, with named players.
class RockPaperScissorRounds < RockPaperScissorGame

attr_reader :score, :rounds_total, :names
attr_accessor :current_round

  def initialize(*names)
    @names = names
    @score = names.map {|name| [name, 0] }.to_h
  end

  def playgame round_num
    @current_round, @rounds_total = round_num, round_num
  end

  def play_round choices = {}
    raise 'Unknown player in the game!' unless (choices.keys - names).empty?

    outcome = choose(choices.values)
    choices.each {|name, choice| @score[name] += 1 if choice == outcome }
    @current_round -= 1 unless outcome == :tie
  end

  def winner?
    @score.values.any? {|score| score == @rounds_total }
  end

  def who_is_winner?
    @score.max_by {|name, score| score }.first
  end

end