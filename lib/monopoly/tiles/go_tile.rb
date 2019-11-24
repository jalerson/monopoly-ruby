module Monopoly::Tiles
  class GoTile < BaseTile
    include Monopoly::Decorators::GoTileDecorator

    REWARD_ON_LANDING = 400.freeze
  end
end
