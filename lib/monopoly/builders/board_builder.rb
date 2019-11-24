module Monopoly::Builders
  class BoardBuilder
    DEFAULT_MOVEMENT_SERVICE = Monopoly::Services::MovePlayerService
    DEFAULT_MOVEMENT_EARNINGS_SERVICE = Monopoly::Services::CalculateMovementEarningsService
    DEFAULT_LANDING_TRANSACTIONS_SERVICE = Monopoly::Services::PerformLandingTransactionsService

    def initialize
      @tile_types = []
      @movement_service = DEFAULT_MOVEMENT_SERVICE
      @movement_earnings_service = DEFAULT_MOVEMENT_EARNINGS_SERVICE
      @landing_transactions_service = DEFAULT_LANDING_TRANSACTIONS_SERVICE
    end

    def self.build
      builder = new
      yield(builder)
      builder.generate_board
    end

    def add_tiles(tile_type, number:, **args)
      raise ArgumentError, 'number must be greater than 0' if number <= 0

      @tile_types << [ tile_type, number, args ].compact
    end

    def set_movement_service(service)
      @movement_service = service
    end

    def set_movement_earnings_service(service)
      @movement_earnings_service = service
    end

    def set_landing_transactions_service(service)
      @landing_transactions_service = service
    end

    def generate_board
      raise 'Unable to generate a board with no tiles' if @tile_types.empty?

      tiles = []

      @tile_types.each do |tile_type, number, args|
        number.times { args.empty? ? tiles << tile_type.new : tiles << tile_type.new(**args) }
      end

      scrambled_tiles = []
      while (tile = tiles.delete(tiles.sample))
        scrambled_tiles << tile
      end

      Monopoly::Board.new(scrambled_tiles,
        movement_service: @movement_service,
        movement_earnings_service: @movement_earnings_service,
        landing_transactions_service: @landing_transactions_service
      )
    end
  end
end
