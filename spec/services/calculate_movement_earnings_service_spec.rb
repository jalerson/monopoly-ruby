RSpec.describe Monopoly::Services::CalculateMovementEarningsService do
  subject { Monopoly::Services::CalculateMovementEarningsService }

  context 'passing over one go tile' do
    let!(:tiles) { [Monopoly::Tiles::GoTile.new] }

    it 'returns 200' do
      earnings = subject.call(tiles: tiles)

      expect(earnings).to eq(200)
    end
  end

  context 'passing over two go tiles' do
    let!(:tiles) { [Monopoly::Tiles::GoTile.new, Monopoly::Tiles::GoTile.new] }

    it 'returns 400' do
      earnings = subject.call(tiles: tiles)

      expect(earnings).to eq(400)
    end
  end

  context 'passing over an empty tile' do
    let!(:tiles) { [Monopoly::Tiles::EmptyTile.new] }

    it 'returns 0' do
      earnings = subject.call(tiles: tiles)

      expect(earnings).to eq(0)
    end
  end

  context 'passing over a property tile' do
    let!(:tiles) { [Monopoly::Tiles::PropertyTile.new] }

    it 'returns 0' do
      earnings = subject.call(tiles: tiles)

      expect(earnings).to eq(0)
    end
  end
end
