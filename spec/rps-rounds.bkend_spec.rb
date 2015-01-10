require 'rps-rounds.bkend'
require 'rps.bkend'

describe RockPaperScissorRounds do

let(:rpsrounds) { RockPaperScissorRounds.new("tom", "bob") }
let(:rps)       { RockPaperScissor.new }

  context 'the game can keep score' do

    it 'can keep score' do
      expect(rpsrounds.score).to eq({"tom" => 0, "bob" => 0})
    end

    it 'can change the score after one round' do
      rpsrounds.playgame 1
      rpsrounds.play_round("tom" => :rock, "bob" => :scissors)
      expect(rpsrounds.score).to eq({"tom" => 1, "bob" => 0})
    end

    it 'wont change the score if tie' do
      rpsrounds.playgame 1
      rpsrounds.play_round("tom" => :rock, "bob" => :rock)
      expect(rpsrounds.score).to eq({"tom" => 0, "bob" => 0})
    end

  end

  context 'the game has a winner' do

    it 'knows when there is a winner' do
      rpsrounds.playgame 1
      rpsrounds.play_round("tom" => :rock, "bob" => :scissors)
      expect(rpsrounds.winner?).to eq(true)
    end

    it 'knows when there isnt a winner' do
      expect(rpsrounds.winner?).to eq(false)
    end

    it 'knows who the winner is' do
      rpsrounds.playgame 1
      rpsrounds.play_round("tom" => :rock, "bob" => :scissors)
      expect(rpsrounds.who_is_winner?).to eq("tom")
    end
  end

  it 'knows what round it is' do
    rpsrounds.playgame 3
    rpsrounds.play_round("tom" => :rock, "bob" => :scissors)
    expect(rpsrounds.current_round).to eq(2)
  end

  context 'errors' do

    it 'knows when someone tries to make a choice who is not in the game' do
      expect(lambda {rpsrounds.play_round("tim" => :rock, "bob" => :scissors)}).to raise_error('Unknown player in the game!')
    end

    it 'knows when you try to play another round when there is a winner' do
      rpsrounds.playgame 1
      rpsrounds.play_round("tom" => :rock, "bob" => :scissors)
      expect( lambda { rpsrounds.play_round("tom" => :rock, "bob" => :scissors) }).to raise_error('Game is over!')
    end
  end



end