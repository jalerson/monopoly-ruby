RSpec.describe Monopoly::Player do
  subject { Monopoly::Player }

  describe 'constants' do
    describe 'DEFAULT_START_BALANCE' do
      it 'returns 1500' do
        expect(subject::DEFAULT_START_BALANCE).to eq(1500)
      end
    end
  end

  describe 'initialization' do
    context 'default start balance' do
      it 'returns a new player with 1500' do
        player = subject.new(1)

        expect(player.balance).to eq(1500)
      end
    end

    context 'custom start balance' do
      it 'returns a new player with 2000' do
        player = subject.new(2, start_balance: 2000)

        expect(player.balance).to eq(2000)
      end
    end
  end

  describe '#add_property' do
    let!(:player) { subject.new(1) }
    let!(:property) { Monopoly::Tiles::PropertyTile.new }

    it 'adds the property to the player' do
      player.add_property(property)

      expect(player.properties).to contain_exactly(property)
    end
  end

  describe '#receives' do
    let!(:player) { subject.new(1) }

    it 'adds the amount to the balance' do
      amount = 500

      expect do
        player.receives(amount)
      end.to change(player, :balance).by(amount)
    end
  end

  describe '#pays' do
    context 'insufficient balance' do
      let!(:player) { subject.new(1, start_balance: 0) }

      it 'deduces the amount from the balance' do
        amount = 100

        expect do
          player.pays(amount)
        end.to change(player, :balance).by(-amount)
      end

      it 'allows the balance to be negative' do
        player.pays(100)

        expect(player.balance).to be_negative
      end
    end

    context 'sufficient balance' do
      let!(:player) { subject.new(1, start_balance: 1000) }

      it 'deduces the amount from the balance' do
        amount = 100

        expect do
          player.pays(amount)
        end.to change(player, :balance).by(-amount)
      end
    end
  end

  describe '#has_balance?' do
    context 'amount is greater than balance' do
      let!(:player) { subject.new(1, start_balance: 0) }

      it 'returns false' do
        expect(player.has_balance?(200)).to be false
      end
    end

    context 'balance is greater than amount' do
      let!(:player) { subject.new(1, start_balance: 1000) }

      it 'returns true' do
        expect(player.has_balance?(200)).to be true
      end
    end
  end
end
