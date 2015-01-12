require_relative 'rps.bkend'


# Can play multi-round games of RPS, with named players.
class RockPaperScissorRounds < RockPaperScissorGame

attr_reader :score, :rounds_total, :names
attr_accessor :current_round

  def initialize(names)
    @names = names
    @score = names.map {|name| [name, 0] }.to_h
  end

  def playgame round_num
    @current_round, @rounds_total = round_num, round_num
  end

  def play_round choices = {}
    validate(choices)
    outcome = choose(choices.values)
    round_outcome(choices, outcome) unless outcome == :tie
    outcome
  end

    def validate choices
      raise 'Unknown player in the game!' unless (choices.keys - names).empty?
      raise 'Game is over!'               if winner?
    end

    def round_outcome choices, outcome
      choices.each {|name, choice| @score[name] += 1 if choice == outcome }
      @current_round -= 1
    end

  def winner?
    (@score.values.max >= @rounds_total) and !tie?
  end

  def who_is_winner?
    @score.max_by {|name, score| score }.first
  end

  def tie?
    @score.select {|name, points| points == @score.values.max }.size > 1
  end


end