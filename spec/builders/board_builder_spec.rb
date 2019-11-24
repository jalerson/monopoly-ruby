RSpec.describe Monopoly::Builders::BoardBuilder do
  subject { Monopoly::Builders::BoardBuilder }

  describe '#build' do
    context 'generate a 40-tiles board' do
      it 'returns a board instance' do
        board = subject.build do |builder|
          builder.add_tiles(Monopoly::Tiles::PropertyTile, number: 28, cost: 100)
          builder.add_tiles(Monopoly::Tiles::GoTile, number: 4)
          builder.add_tiles(Monopoly::Tiles::EmptyTile, number: 8)
        end

        expect(board).to be_an_instance_of(Monopoly::Board)
      end

      it 'returns a board with 40 tiles' do
        board = subject.build do |builder|
          builder.add_tiles(Monopoly::Tiles::PropertyTile, number: 28, cost: 100)
          builder.add_tiles(Monopoly::Tiles::GoTile, number: 4)
          builder.add_tiles(Monopoly::Tiles::EmptyTile, number: 8)
        end

        expect(board.tiles.size).to eq(40)
      end
    end

    context 'generate a board with no tiles' do
      it 'raises an error' do
        expect do
          board.build
        end.to raise_error(StandardError)
      end
    end
  end
end
