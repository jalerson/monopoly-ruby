RSpec.describe Monopoly::Services::PerformLandingTransactionsService do
  subject { Monopoly::Services::PerformLandingTransactionsService }

  context 'player landed in a go tile' do
    let!(:player) { Monopoly::Player.new(1, start_balance: 0) }
    let!(:tile) { Monopoly::Tiles::GoTile.new }

    it 'earns 400' do
      expect do
        subject.call(tile: tile, player: player)
      end.to change(player, :balance).by(400)
    end
  end

  context 'player landed in a property tile' do
    context 'the property has an owner' do
      context 'by the current player' do
        let!(:player) { Monopoly::Player.new(1, start_balance: 1000) }
        let!(:tile) { Monopoly::Tiles::PropertyTile.new(owner: player) }

        it 'doesnt change the player balance' do
          expect do
            subject.call(tile: tile, player: player)
          end.not_to change(player, :balance)
        end
      end

      context 'by other player' do
        let!(:player) { Monopoly::Player.new(1, start_balance: 1000) }
        let!(:owner) { Monopoly::Player.new(2, start_balance: 500) }
        let!(:tile) { Monopoly::Tiles::PropertyTile.new(owner: owner) }

        it 'deduces the rent from the player' do
          expect do
            subject.call(tile: tile, player: player)
          end.to change(player, :balance).by(-tile.cost)
        end

        it 'grants the rent to the owner' do
          expect do
            subject.call(tile: tile, player: player)
          end.to change(owner, :balance).by(tile.cost)
        end
      end
    end

    context 'the property has no owner' do
      context 'the player has balance' do
        let!(:player) { Monopoly::Player.new(1, start_balance: 1000) }
        let!(:tile) { Monopoly::Tiles::PropertyTile.new }

        it 'deduces the cost from the player' do
          expect do
            subject.call(tile: tile, player: player)
          end.to change(player, :balance).by(-tile.cost)
        end

        it 'changes the ownership' do
          expect do
            subject.call(tile: tile, player: player)
          end.to change(tile, :owner)
          expect(tile.owner).to eq(player)
        end
      end

      context 'the player has no balance' do
        let!(:player) { Monopoly::Player.new(1, start_balance: 0) }
        let!(:tile) { Monopoly::Tiles::PropertyTile.new }

        it 'doesnt change the player balance' do
          expect do
            subject.call(tile: tile, player: player)
          end.not_to change(player, :balance)
        end

        it 'keeps the tile ownerless' do
          expect do
            subject.call(tile: tile, player: player)
          end.not_to change(tile, :owner)
        end
      end
    end
  end

  context 'player landed in an empty tile' do
    let!(:player) { Monopoly::Player.new(1, start_balance: 1000) }
    let!(:tile) { Monopoly::Tiles::EmptyTile.new }

    it 'doesnt change player balance' do
      expect do
        subject.call(tile: tile, player: player)
      end.not_to change(player, :balance)
    end
  end
end
