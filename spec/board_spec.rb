RSpec.describe Monopoly::Board do
  describe '#move' do
    let!(:player) { Monopoly::Player.new(1) }

    context '10-tiles board size' do
      let!(:board) {
        Monopoly::Builders::BoardBuilder.build do |builder|
          builder.add_tiles(Monopoly::Tiles::EmptyTile, number: 10)
        end
      }

      context 'moving 5 steps from position 0' do
        it 'moves the player to position 5' do
          player.position = 0

          board.move(player: player, steps: 5)

          expect(player.position).to eq(5)
        end
      end

      context 'moving 10 steps from position 5' do
        it 'moves the player to position 5' do
          player.position = 5

          board.move(player: player, steps: 10)

          expect(player.position).to eq(5)
        end
      end
    end
  end
end
