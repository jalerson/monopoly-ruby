module Monopoly::Builders
  class MatchBuilder
    attr_reader :dices, :players, :board

    MIN_PLAYERS = 2
    MAX_PLAYERS = 4
    MIN_DICES = 2

    def initialize
      @dices = []
      @players = []
    end

    def self.build
      builder = new
      yield(builder)

      raise "dices must be >= #{MIN_DICES}" if builder.dices.size < MIN_DICES
      unless builder.players.size.between?(MIN_PLAYERS, MAX_PLAYERS)
        raise "players must be in range [#{MIN_PLAYERS}..#{MAX_PLAYERS}]"
      end
      raise 'board must be set' if builder.board.nil?

      Monopoly::Match.new(players: builder.players, dices: builder.dices, board: builder.board)
    end

    def add_player(player)
      @players << player
    end

    def add_dice(dice)
      @dices << dice
    end

    def set_board(board)
      @board = board
    end
  end
end
