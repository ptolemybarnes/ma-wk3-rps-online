require 'rps-multiplayer.bkend'

describe RpsMultiplayer do

let(:rps) { RpsMultiplayer.new }

  it 'can store player names' do
    rps.add_player("John")
    rps.add_player("Tom")
    expect(rps.player_list).to eq(["John", "Tom"])
  end

  it 'can set whether a game is in progress' do
    expect(rps.game_in_progress).to eq(false)
    rps.game_in_progress = true
    expect(rps.game_in_progress).to eq(true)
  end

  it 'knows how many players there are' do
    rps.add_player("John")
    rps.add_player("Tom")
    expect(rps.player_count).to eq(2)
  end

  it 'knows when the requisite number of players have joined to play' do
    rps.player_cap = 2
    expect(rps.game_ready?).to eq(false)
    rps.add_player("John")
    rps.add_player("Tom")
    expect(rps.game_ready?).to eq(true)
  end

  it 'can build a list of moves' do
    rps.add_player("John")
    rps.add_player("Tom")
    rps.moves << ["Tom", :scissors]
    rps.moves << ["John", :scissors]
    expect(rps.moves).to eq([["Tom", :scissors], ["John", :scissors]])
  end

  it 'knows when all moves have been built' do
    rps.add_player("John")
    rps.add_player("Tom")
    rps.moves << ["Tom", :scissors]
    rps.moves << ["John", :scissors]
    expect(rps.ready?).to eq(true)
  end

  it 'knows when its sudden death!' do
    rps.round_num = 3
    rps.add_player("John")
    rps.add_player("Tom")
    rps.add_player("Fred")
    rps.start_game
    rps.moves << ["Tom", :scissors]
    rps.moves << ["John", :rock]
    rps.moves << ["Fred", :rock]
    rps.play_round
    rps.moves << ["Tom", :scissors]
    rps.moves << ["John", :rock]
    rps.moves << ["Fred", :rock]
    rps.play_round
    rps.moves << ["Tom", :scissors]
    rps.moves << ["John", :rock]
    rps.moves << ["Fred", :rock]
    rps.play_round
    expect(rps.sudden_death?).to eq(true)
    end

end