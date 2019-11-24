module Monopoly::Tiles
  class PropertyTile < BaseTile
    include Monopoly::Decorators::PropertyTileDecorator

    attr_reader :cost
    attr_accessor :owner

    DEFAULT_PROPERTY_COST = 100

    def initialize(cost: DEFAULT_PROPERTY_COST, owner: nil)
      @cost = cost
      @owner = owner
    end

    def has_owner?
      !owner.nil?
    end

    def bought_by(player)
      return false unless player.has_balance?(cost)

      player.pays(cost)
      @owner = player
      player.add_property(self)
    end
  end
end
