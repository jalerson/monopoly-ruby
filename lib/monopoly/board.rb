module Monopoly
  class Board
    attr_accessor :tiles

    def initialize(tiles, movement_service:, movement_earnings_service:, landing_transactions_service:)
      @tiles = tiles
      @movement_service = movement_service
      @movement_earnings_service = movement_earnings_service
      @landing_transactions_service = landing_transactions_service
    end

    def move(player:, steps:)
      @movement_service.(
        player: player,
        tiles: tiles,
        steps: steps,
        movement_earnings_service: @movement_earnings_service,
        landing_transactions_service: @landing_transactions_service
      )
    end
  end
end
