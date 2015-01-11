require 'rps-multiplayer.bkend'

describe RpsMultiplayer do

let(:rps) { RpsMultiplayer.new }

  it 'can store player names' do
    rps.add_player("John")
    rps.add_player("Tom")
    expect(rps.player_list).to eq(["John", "Tom"])
  end

  it 'can play a game of Rps with 3 rounds' do
    rps.start_game(3)
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

end