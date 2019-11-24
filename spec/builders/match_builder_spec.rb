RSpec.describe Monopoly::Builders::MatchBuilder do
  subject { Monopoly::Builders::MatchBuilder }

  let!(:board) {
    Monopoly::Builders::BoardBuilder.build do |builder|
      builder.add_tiles(Monopoly::Tiles::PropertyTile, number: 28, cost: 100)
      builder.add_tiles(Monopoly::Tiles::GoTile, number: 4)
      builder.add_tiles(Monopoly::Tiles::EmptyTile, number: 8)
    end
  }

  describe '#build' do
    context 'building a 2-players and 2-dices match' do
      let(:match) {
        subject.build do |builder|
          builder.add_player(Monopoly::Player.new(1))
          builder.add_player(Monopoly::Player.new(2))
          builder.add_dice(Monopoly::Dice.new)
          builder.add_dice(Monopoly::Dice.new)
          builder.set_board(board)
        end
      }

      it 'returns a match instance' do
        expect(match).to be_an_instance_of(Monopoly::Match)
      end

      it 'returns a match with 2 players' do
        expect(match.players.size).to eq(2)
      end

      it 'returns a match with 2 dices' do
        expect(match.dices.size).to eq(2)
      end
    end

    context 'building a 5-players match' do
      it 'raises an error' do
        expect do
          subject.build do |builder|
            builder.add_player(Monopoly::Player.new(1))
            builder.add_player(Monopoly::Player.new(2))
            builder.add_player(Monopoly::Player.new(3))
            builder.add_player(Monopoly::Player.new(4))
            builder.add_player(Monopoly::Player.new(5))
            builder.add_dice(Monopoly::Dice.new)
            builder.add_dice(Monopoly::Dice.new)
            builder.set_board(board)
          end
        end.to raise_error(RuntimeError)
      end
    end

    context 'building a 1-dice match' do
      it 'raises an error' do
        expect do
          subject.build do |builder|
            builder.add_player(Monopoly::Player.new(1))
            builder.add_player(Monopoly::Player.new(2))
            builder.add_dice(Monopoly::Dice.new)
            builder.set_board(board)
          end
        end.to raise_error(RuntimeError)
      end
    end

    context 'building a match without board' do
      it 'raises an error' do
        expect do
          subject.build do |builder|
            builder.add_player(Monopoly::Player.new(1))
            builder.add_player(Monopoly::Player.new(2))
            builder.add_dice(Monopoly::Dice.new)
            builder.add_dice(Monopoly::Dice.new)
          end
        end.to raise_error(RuntimeError)
      end
    end
  end
end
