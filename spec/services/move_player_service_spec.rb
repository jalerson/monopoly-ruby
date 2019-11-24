RSpec.describe Monopoly::Services::MovePlayerService do
  subject { Monopoly::Services::MovePlayerService }

  let!(:movement_earnings_service) { Monopoly::Services::CalculateMovementEarningsService }
  let!(:landing_transactions_service) { Monopoly::Services::PerformLandingTransactionsService }
  let!(:player) { Monopoly::Player.new(1) }

  context '10-tiles board' do
    let!(:tiles) { (1..10).map { Monopoly::Tiles::EmptyTile.new } }

    context 'moving 5 steps from position 0 (within board size)' do
      it 'moves the player to position 5' do
        player.position = 0

        subject.call(player: player, tiles: tiles, steps: 5,
          movement_earnings_service: movement_earnings_service,
          landing_transactions_service: landing_transactions_service
        )

        expect(player.position).to eq(5)
      end
    end

    context 'moving 5 steps from position 8 (beyond board size)' do
      it 'moves the player to position 3' do
        player.position = 8

        subject.call(player: player, tiles: tiles, steps: 5,
          movement_earnings_service: movement_earnings_service,
          landing_transactions_service: landing_transactions_service
        )

        expect(player.position).to eq(3)
      end
    end
  end
end
