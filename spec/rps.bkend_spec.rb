require 'rps.bkend'

describe RockPaperScissor do

let(:rps) { RockPaperScissor.new }

  it 'returns rock when rock versus scissors' do
    expect(rps.choose(:scissors,:rock)).to eq :rock
    expect(rps.choose(:rock, :scissors)).to eq :rock
  end

  it 'returns paper when paper versus rock' do
    expect(rps.choose(:paper,  :rock)).to eq :paper
    expect(rps.choose(:rock , :paper)).to eq :paper
  end

  it 'returns scissors when scissors versus paper' do
    expect(rps.choose(:scissors, :paper)).to eq :scissors
    expect(rps.choose(:paper, :scissors)).to eq :scissors
  end

  it 'returns tie when choices are the same' do
    expect(rps.choose(:paper,       :paper)).to eq :tie
    expect(rps.choose(:rock ,       :rock )).to eq :tie
    expect(rps.choose(:scissors, :scissors)).to eq :tie
  end
end