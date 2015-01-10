class RockPaperScissorGame

  def choose choices
    return :tie if choices.uniq.size != 2
    get_winner choices.first, choices.last
  end

  def get_winner choice1, choice2
    case choice1
    when :rock
      rock_versus choice2
    when :paper
      paper_versus choice2
    when :scissors
      scissors_versus choice2
    end
  end

  def rock_versus choice
    choice == :scissors ? :rock : :paper
  end

  def paper_versus choice
    choice == :rock ? :paper : :scissors
  end

  def scissors_versus choice
    choice == :paper ? :scissors : :rock
  end

  def self.random_choice
    [:rock, :paper, :scissors].sample
  end

end