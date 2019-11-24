RSpec.describe Monopoly::Decorators::PropertyTileDecorator do
  DummyPropertyTileClass = Class.new do
    include Monopoly::Decorators::PropertyTileDecorator

    def has_owner?; end
    def owner; end
  end

  describe '#name' do
    context 'owned property' do
      it 'returns P1' do
        property_tile = DummyPropertyTileClass.new
        allow(property_tile).to receive(:has_owner?).and_return(true)
        owner = double('player', number: 1)
        allow(property_tile).to receive(:owner).and_return(owner)

        expect(property_tile.name).to eq('P1 ')
      end
    end

    context 'ownerless property' do
      it 'returns P' do
        property_tile = DummyPropertyTileClass.new
        allow(property_tile).to receive(:has_owner?).and_return(false)

        expect(property_tile.name).to eq('P  ')
      end
    end
  end
end
