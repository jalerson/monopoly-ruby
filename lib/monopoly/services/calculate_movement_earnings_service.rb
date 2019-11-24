module Monopoly::Services
  class CalculateMovementEarningsService < BaseService
    PROFITABLE_TILES = {
      Monopoly::Tiles::GoTile => 200
    }.freeze

    def call(tiles:)
      earnings = 0
      tiles.map { |tile| earnings += PROFITABLE_TILES[tile.class] if PROFITABLE_TILES.key?(tile.class) }
      earnings
    end
  end
end
