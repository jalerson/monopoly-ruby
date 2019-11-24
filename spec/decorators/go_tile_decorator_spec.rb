RSpec.describe Monopoly::Decorators::GoTileDecorator do
  DummyGoTileClass = Class.new do
    include Monopoly::Decorators::GoTileDecorator
  end

  describe '#name' do
    it 'returns G' do
      expect(DummyGoTileClass.new.name).to eq('G  ')
    end
  end
end
