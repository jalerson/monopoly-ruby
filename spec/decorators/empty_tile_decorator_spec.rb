RSpec.describe Monopoly::Decorators::EmptyTileDecorator do
  DummyEmptyTileClass = Class.new do
    include Monopoly::Decorators::EmptyTileDecorator
  end

  describe '#name' do
    it 'returns _' do
      expect(DummyEmptyTileClass.new.name).to eq('_  ')
    end
  end
end
