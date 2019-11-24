module Monopoly
  class Match
    attr_reader :players, :current_player, :dices, :board

    def initialize(players:, dices:, board:)
      @players = players
      @dices = dices
      @board = board
    end

    def roll
      next_player
      steps = dices.map(&:roll).sum
      board.move(player: current_player, steps: steps)

      steps
    end

    # @deprecated Please use {Monopoly::Builders::MatchBuilder} instead
    def new_game(player_names)
      board = Monopoly::Builders::BoardBuilder.build do |builder|
        builder.add_tiles(Monopoly::Tiles::PropertyTile, number: 28, cost: 100)
        builder.add_tiles(Monopoly::Tiles::GoTile, number: 4)
        builder.add_tiles(Monopoly::Tiles::EmptyTile, number: 8)
      end

      Monopoly::Builders::MatchBuilder.build do |builder|
        1.upto(player_names.size) { |i| builder.add_player(Monopoly::Player.new(i)) }
        builder.add_dice(Monopoly::Dice.new)
        builder.add_dice(Monopoly::Dice.new)
        builder.set_board(board)
      end
    end

    private

    def next_player
      if current_player.nil?
        @current_player = players.first
        return current_player
      end

      current_index = players.index(current_player)
      next_index = current_index == (players.size - 1) ? 0 : current_index + 1

      @current_player = players[next_index]
      current_player
    end
  end
end
