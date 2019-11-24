module Monopoly::Tiles
  class EmptyTile < BaseTile
    include Monopoly::Decorators::EmptyTileDecorator
  end
end
