module Monopoly::Services
  class PerformLandingTransactionsService < BaseService
    def call(tile:, player:)
      case tile
      when Monopoly::Tiles::GoTile
        player.receives(Monopoly::Tiles::GoTile::REWARD_ON_LANDING)
      when Monopoly::Tiles::PropertyTile
        perform_property_transactions(tile, player)
      end
    end

    private

    def perform_property_transactions(tile, player)
      if tile.has_owner?
        if tile.owner != player
          player.pays(tile.cost)
          tile.owner.receives(tile.cost)
        end
      else
        tile.bought_by(player)
      end
    end
  end
end
