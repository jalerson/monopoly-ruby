module Monopoly::Services
  class MovePlayerService < BaseService
    def call(player:, tiles:, steps:, movement_earnings_service:, landing_transactions_service:)
      final_position = calculate_final_position(player.position, steps, tiles.size)
      tiles_in_between = tiles_between(tiles, player.position, final_position)
      calculate_movement_earnings(tiles_in_between, player, movement_earnings_service)

      perform_landing_transactions(tiles[final_position], player, landing_transactions_service)
      player.position = final_position
    end

    private

    def perform_landing_transactions(tile, player, service)
      service.(tile: tile, player: player)
    end

    def calculate_movement_earnings(tiles, player, service)
      earnings = service.(tiles: tiles)
      player.receives(earnings)
    end

    def calculate_final_position(start_position, steps, board_size)
      final_position = start_position + steps
      final_position -= board_size if final_position >= board_size

      final_position
    end

    def tiles_between(tiles, start_position, end_position)
      if end_position > start_position
        tiles[(start_position + 1)...end_position]
      else
        tiles[(start_position + 1)..-1] + tiles[0...end_position]
      end
    end
  end
end
