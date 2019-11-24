RSpec.describe Monopoly::Tiles::PropertyTile do
  subject { Monopoly::Tiles::PropertyTile }

  describe 'constants' do
    describe 'DEFAULT_PROPERTY_COST' do
      it 'returns 100' do
        expect(subject::DEFAULT_PROPERTY_COST).to eq(100)
      end
    end
  end

  describe 'initialization' do
    context 'default' do
      it 'creates an instance with default cost' do
        tile = subject.new

        expect(tile.cost).to eq(subject::DEFAULT_PROPERTY_COST)
      end

      it 'creates an instance with no owner' do
        tile = subject.new

        expect(tile.owner).to be_nil
      end
    end

    context 'setting an custom cost and owner' do
      let!(:owner) { Monopoly::Player.new(1) }

      it 'creates an instance with custom cost' do
        tile = subject.new(cost: 200)

        expect(tile.cost).to eq(200)
      end

      it 'creates an instance with an owner' do
        tile = subject.new(owner: owner)

        expect(tile.owner).to eq(owner)
      end
    end
  end

  describe '#has_owner?' do
    context 'ownerless property' do
      it 'returns false' do
        tile = subject.new

        expect(tile.has_owner?).to be false
      end
    end

    context 'owned property' do
      let!(:owner) { Monopoly::Player.new(1) }

      it 'returns false' do
        tile = subject.new(owner: owner)

        expect(tile.has_owner?).to be true
      end
    end
  end

  describe '#bought_by' do
    context 'player has balance' do
      let!(:player) { Monopoly::Player.new(1, start_balance: 1000) }
      let!(:tile) { subject.new }

      it 'deduces the cost from player' do
        expect do
          tile.bought_by(player)
        end.to change(player, :balance).by(-tile.cost)
      end

      it 'sets the player as owner' do
        tile.bought_by(player)

        expect(tile.owner).to be(player)
      end

      it 'adds the property to player properties' do
        tile.bought_by(player)

        expect(player.properties).to contain_exactly(tile)
      end
    end

    context 'player has no balance' do
      let!(:player) { Monopoly::Player.new(1, start_balance: 0) }
      let!(:tile) { subject.new }

      it 'returns false' do
        expect(tile.bought_by(player)).to be false
      end

      it 'doesnt change player balance' do
        expect do
          tile.bought_by(player)
        end.not_to change(player, :balance)
      end

      it 'doesnt change tile owner' do
        expect do
          tile.bought_by(player)
        end.not_to change(tile, :owner)
      end
    end
  end
end
