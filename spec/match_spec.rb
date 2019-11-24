RSpec.describe Monopoly::Match do
  let!(:board) {
    Monopoly::Builders::BoardBuilder.build do |builder|
      builder.add_tiles(Monopoly::Tiles::PropertyTile, number: 28, cost: 100)
      builder.add_tiles(Monopoly::Tiles::GoTile, number: 4)
      builder.add_tiles(Monopoly::Tiles::EmptyTile, number: 8)
    end
  }

  let!(:player_1) { Monopoly::Player.new(1) }
  let!(:player_2) { Monopoly::Player.new(2) }

  let!(:dice_1) { Monopoly::Dice.new }
  let!(:dice_2) { Monopoly::Dice.new }

  let!(:match) {
    Monopoly::Builders::MatchBuilder.build do |builder|
      builder.add_player(player_1)
      builder.add_player(player_2)
      builder.add_dice(dice_1)
      builder.add_dice(dice_2)
      builder.set_board(board)
    end
  }

  describe '#roll' do
    context 'first turn (Player 1)' do
      it 'sets the Player 1 as current player' do
        match.roll

        expect(match.current_player).to eq(player_1)
      end

      it 'rolls the dices' do
        allow(dice_1).to receive(:roll).and_return(2)
        allow(dice_2).to receive(:roll).and_return(3)

        expect(match.roll).to eq(5)
      end

      it 'moves the player 1' do
        allow(dice_1).to receive(:roll).and_return(2)
        allow(dice_2).to receive(:roll).and_return(3)

        expect do
          match.roll
        end.to change(player_1, :position).by(5)
      end

      it 'doesnt move the player 2' do
        expect do
          match.roll
        end.not_to change(player_2, :position)
      end
    end

    context 'second turn (Player 2)' do
      before(:each) do
        match.roll
      end

      it 'sets the Player 2 as current player' do
        match.roll

        expect(match.current_player).to eq(player_2)
      end

      it 'rolls the dices' do
        allow(dice_1).to receive(:roll).and_return(5)
        allow(dice_2).to receive(:roll).and_return(6)

        expect(match.roll).to eq(11)
      end

      it 'moves the player 2' do
        allow(dice_1).to receive(:roll).and_return(5)
        allow(dice_2).to receive(:roll).and_return(6)

        expect do
          match.roll
        end.to change(player_2, :position).by(11)
      end

      it 'doesnt move the player 1' do
        expect do
          match.roll
        end.not_to change(player_1, :position)
      end
    end

    context 'third turn (Player 1)' do
      before(:each) do
        match.roll
        match.roll
      end

      it 'sets the Player 1 as current player' do
        match.roll

        expect(match.current_player).to eq(player_1)
      end

      it 'rolls the dices' do
        allow(dice_1).to receive(:roll).and_return(2)
        allow(dice_2).to receive(:roll).and_return(1)

        expect(match.roll).to eq(3)
      end

      it 'moves the player 1' do
        allow(dice_1).to receive(:roll).and_return(2)
        allow(dice_2).to receive(:roll).and_return(1)

        expect do
          match.roll
        end.to change(player_1, :position).by(3)
      end

      it 'doesnt move the player 2' do
        expect do
          match.roll
        end.not_to change(player_2, :position)
      end
    end
  end

  describe '#new_game' do
    context 'with 4 players' do
      let!(:player_names) { ['Player 1', 'Player 2', 'Player 3', 'Player 4'] }

      it 'returns a new match' do
        new_match = match.new_game(player_names)

        expect(new_match).to be_an_instance_of(Monopoly::Match)
      end

      it 'contains four players' do
        new_match = match.new_game(player_names)

        expect(new_match.players.size).to eq(4)
      end
    end
  end

  describe '#current_player' do
    context 'first round' do
      it 'returns player 1' do
        match.roll

        expect(match.current_player).to eq(player_1)
      end
    end

    context 'second round' do
      it 'returns player 2' do
        match.roll
        match.roll

        expect(match.current_player).to eq(player_2)
      end
    end

    context 'third round' do
      it 'returns player 1' do
        3.times { match.roll }

        expect(match.current_player).to eq(player_1)
      end
    end
  end

  describe '#players' do
    it 'returns an array of players' do
      expect(match.players).to contain_exactly(player_1, player_2)
    end
  end
end
