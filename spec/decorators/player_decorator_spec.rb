RSpec.describe Monopoly::Decorators::PlayerDecorator do
  DummyPlayerClass = Class.new do
    include Monopoly::Decorators::PlayerDecorator

    def number
      1
    end
  end

  describe '#name' do
    it 'returns Player 1' do
      expect(DummyPlayerClass.new.name).to eq('Player 1')
    end
  end
end
