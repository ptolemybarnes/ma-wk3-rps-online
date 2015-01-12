require 'player.bkend'

describe Player do

  it 'has a name' do
    expect(Player.new(name: "Cleo").name).to eq("Cleo")
  end

  it 'has a type' do
    expect(Player.new(type: :computer).type).to eq(:computer)
  end

  it 'knows a move' do
    player = Player.new
    player.choice = :scissors
    expect(player.choice).to eq(:scissors)
  end
end